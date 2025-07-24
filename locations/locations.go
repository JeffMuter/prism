package locations

import (
	"context"
	"errors"
	"fmt"
	"prism/db"
	"prism/db/sqlc"
	"prism/user"
	"prism/util"
)

// create location adds location to the location, user_location, and adds an egg to user's inventory.
func CreateLocation(user user.User, locName string, locTypeId int) (int, error) {
	var newLocationRowId int
	var newUsersLocsId int
	//this num signifies 10 miles in lat/long degrees. We're using this to
	// determine the max / min lat&long to determine if the node we want to place is too close to another node.
	var latLongRange float64 = 0.145

	// call func to get the vars for the lat/long range
	minLat, maxLat, minLong, maxLong := util.GetMaxLocationRanges(latLongRange, user.Latitude, user.Longitude)

	locations, err := GetAllLocations(user)

	// check each location, if any node is too close, cancel the process
	for _, loc := range locations {
		if loc.Latitude > minLat && loc.Latitude < maxLat && loc.Longitude > minLong && loc.Longitude < maxLong {
			return newLocationRowId, fmt.Errorf("node location too close to another: %s", loc.Name)
		}
	}

	queries := db.GetQueries()
	ctx := context.Background()

	// add node to locations
	query := `INSERT INTO locations 
		(
		default_accessible, 
		latitude, 
		longitude, 
		name, 
		description, 
		art, 
		location_type_id, 
		is_user_created
		) 
	VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) 
	RETURNING id`
	// TODO: cannot be using all these lame hard coded values here...
	// made the location art custom to the type of location...
	db.QueryRow(query, "false", user.Latitude, user.Longitude, locName, "new node description", "node", locTypeId, true).Scan(&newLocationRowId)

	query = `INSERT INTO users_locations 
	(user_id, location_id, name) 
	VALUES ($1, $2, $3) RETURNING id`
	err = db.QueryRow(query, user.Id, newLocationRowId, locName).Scan(&newUsersLocsId)
	if err != nil {
		return newLocationRowId, fmt.Errorf("error inserting users_locations when creating new location: %v\n", err)
	}
	return newUsersLocsId, nil
}

// GetAllLocations used to get locations from the database, placed into a location type.
func GetAllLocations(user user.User) ([]Location, error) {
	var locations []Location

	queries := db.GetQueries()
	ctx := context.Background()

	// query grabs all locations where they're intentionally visible from default, or if the user has visited them. visiting a location, or making one, adds it to users_locations, after all.
	query := `SELECT *
	FROM locations l 
	LEFT JOIN users_locations ul ON l.id = ul.location_id 
	WHERE ul.user_id = ?
	OR l.default_accessible = TRUE
	)`

	rows, err := db.Query(query, user.Id)
	if err != nil {
		return locations, fmt.Errorf("err querying db for all loc related to user's id (id: %d): %w,", user.Id, err)
	}

	for rows.Next() {
		var location Location
		err := rows.Scan(&location.Name, &location.Latitude, &location.Longitude, &location.ArtFileName)
		if err != nil {
			return locations, fmt.Errorf("error looping through rows to assign values to locations as we got rows on all locations related to the user: %w,", err)
		}

		locations = append(locations, location)
	}
	return locations, nil
}

// ConnectToLocation allows a user to see if they can make a new node in this location. Checks a lat/long
// range, and if no other locations are inside it, creates the new node. Returns the id of the newly connected location.
func ConnectToLocation(user user.User) (int, error) {

	var newUsersLocsId int

	queries := db.GetQueries()
	ctx := context.Background()

	// get all locations currently not associated to this user
	query := `SELECT 
		l.id, 
		ul.name, 
		l.latitude, 
		l.longitude 
	FROM locations l 
	LEFT JOIN users_locations ul ON l.id = ul.location_id 
	AND ul.user_id = $1 
	WHERE ul.user_id IS NULL`
	rows, err := db.Query(query, user.Id)
	if err != nil {
		return newUsersLocsId, fmt.Errorf("err querying db for connect to node: %v", err)
	}
	// a range of roughly .1 miles in lat/long.
	minLat, maxLat, minLong, maxLong := util.GetMaxLocationRanges(.5, user.Latitude, user.Longitude)
	var locations []Location

	for rows.Next() {
		var location Location
		err := rows.Scan(&location.Id, &location.Name, &location.Latitude, &location.Longitude)
		if err != nil {
			return newUsersLocsId, fmt.Errorf("error scanning values from row in rows.next, err: %v\n", err)
		}
		if location.Latitude < maxLat && location.Latitude > minLat && location.Longitude < maxLong && location.Longitude > minLong {

			query = `INSERT INTO users_locations (user_id, location_id) 
			VALUES ($1, $2) 
			RETURNING id;`
			err = db.QueryRow(query, user.Id, location.Id).Scan(&newUsersLocsId)
			if err != nil {
				return newUsersLocsId, fmt.Errorf("error inserting new users_locations while connecting to new location: %v\n", err)
			}
			return newUsersLocsId, nil
		}
		locations = append(locations, location)
	}

	return newUsersLocsId, errors.New("could not find a node close enough to connect to")
}

// GetLocationsForUser takes a userId, and returns a slice of locations, made from the db, that
// are related to that user.
func GetLocationsForUser(userId int) ([]sqlc.GetUserLocationsRow, error) {

	queries := db.GetQueries()
	ctx := context.Background()

	fmt.Println(userId)

	locationRows, err := queries.GetUserLocations(ctx, int64(userId))
	if err != nil {
		return locationRows, fmt.Errorf("error querying database for locations: %w", err)
	}

	return locationRows, nil
}

// RemoveWorkerFromNode reduces worker_count value in the db by 1
func RemoveWorkerFromNode(locationId int) error {

	queries := db.GetQueries()
	ctx := context.Background()

	query := `UPDATE users_locations 
	SET worker_count = worker_count - 1 
	WHERE users_locations.id = $1`

	_, err := db.Exec(query, locationId)
	if err != nil {
		fmt.Println("Error subtracting from worker_count", err)
		return fmt.Errorf("error subtracting 1 from worker_count on users_locations table: %w,", err)
	}

	return nil
}

// AddWorkerToNode updates the new node in the db to increase by 1.
func AddWorkerToNode(locationId int) error {

	queries := db.GetQueries()
	ctx := context.Background()

	query := `UPDATE users_locations 
	SET worker_count = worker_count + 1 
	WHERE users_locations.id = $1`

	_, err := db.Exec(query, locationId)
	if err != nil {
		fmt.Println("Error subtracting from worker_count", err)
		return fmt.Errorf("error adding to worker_count on users_locations table: %w,", err)
	}

	return nil
}

// GetTasksForLocation gets all task names for a location, using the location
func GetTaskNamesForLocationType(locationTypeId int) ([]string, error) {

	fmt.Printf("getting task name from id: %d\n", locationTypeId)

	queries := db.GetQueries()
	ctx := context.Background()

	var taskTypes []string
	query := `SELECT tt.name 
	FROM task_types tt 
	JOIN location_types_tasks ltt ON tt.id = ltt.task_type_id 
	JOIN location_types lt ON ltt.location_type_id = lt.id 
	WHERE lt.id = $1`

	rows, err := db.Query(query, locationTypeId)
	if err != nil {
		return taskTypes, err
	}

	for rows.Next() {
		var taskTypeName string
		err := rows.Scan(&taskTypeName)
		if err != nil {
			return taskTypes, err
		}
		taskTypes = append(taskTypes, taskTypeName)
	}

	return taskTypes, nil
}

func GetLocationFromLocationId(id int) (Location, error) {

	queries := db.GetQueries()
	ctx := context.Background()

	query := `SELECT 
		l.id, 
		ul.id, 
		location_type_id, 
		latitude, 
		longitude, 
		ul.name, 
		description, 
		art 
	FROM locations l
	JOIN users_locations ul ON ul.location_id = l.id
	WHERE id = $1`

	row := db.QueryRow(query, id)

	err := row.Scan(&location.Id, &location.LocationTypeId, &location.Latitude, &location.Longitude, &location.Name, &location.Description, &location.ArtFileName)
	if err != nil {
		return location, fmt.Errorf("error scanning location data from locId: %w,", err)
	}

	return location, nil
}
