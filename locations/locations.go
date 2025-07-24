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
// idk if egg is being created here bro
func CreateLocation(user user.User, locName string, locTypeId int) (int, error) {
	var newLocationRowId int

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
	params := sqlc.CreateLocationParams{
		DefaultAccessible: false,
		Latitude:          user.Latitude,
		Longitude:         user.Longitude,
		Name:              locName,
		Description:       "new node desc",
		Art:               "node",
		LocationTypeID:    int64(locTypeId),
		IsUserCreated:     true,
	}

	locId, err := queries.CreateLocation(ctx, params)

	newParams := sqlc.CreateUserLocationParams{
		UserID:     int64(user.Id),
		LocationID: locId,
		Name:       db.StringToNullString(locName),
	}

	// not sure if we're getting the right int here.
	newLocId, err := queries.CreateUserLocation(ctx, newParams)
	if err != nil {
		return newLocationRowId, fmt.Errorf("error inserting users_locations when creating new location: %v\n", err)
	}
	return int(newLocId), nil
}

// GetAllLocations used to get locations from the database, placed into a location type.
func GetAllLocations(user user.User) ([]sqlc.GetVisibleLocationsByUserRow, error) {

	queries := db.GetQueries()
	ctx := context.Background()

	// query grabs all locations where they're intentionally visible from default, or if the user has visited them. visiting a location, or making one, adds it to users_locations, after all.

	rows, err := queries.GetVisibleLocationsByUser(ctx, int64(user.Id))
	if err != nil {
		return rows, fmt.Errorf("err querying db for all loc related to user's id (id: %d): %w,", user.Id, err)
	}

	return rows, nil
}

// ConnectToLocation allows a user to see if they can make a new node in this location. Checks a lat/long
// range, and if no other locations are inside it, creates the new node. Returns the id of the newly connected location.
func ConnectToLocation(user user.User) (int, error) {

	queries := db.GetQueries()
	ctx := context.Background()

	var newUsersLocsId int

	// get all locations this user has not connected to
	locs, err := queries.GetUnconnectedLocations(ctx, int64(user.Id))
	if err != nil {
		return newUsersLocsId, fmt.Errorf("err querying db for connect to node: %v", err)
	}

	// a range of roughly .1 miles in lat/long, used to determine if user should be allowed to connect to this loc
	minLat, maxLat, minLong, maxLong := util.GetMaxLocationRanges(.5, user.Latitude, user.Longitude)

	for _, loc := range locs {

		// if this location is within range of the user, they can connect
		if loc.Latitude < maxLat && loc.Latitude > minLat && loc.Longitude < maxLong && loc.Longitude > minLong {

			params := sqlc.CreateUserLocationParams{
				UserID:     int64(user.Id),
				LocationID: int64(loc.ID),
				Name:       loc.Name,
			}

			// create a user-location
			userLocId, err := queries.CreateUserLocation(ctx, params)
			if err != nil {
				return int(userLocId), fmt.Errorf("error inserting new users_locations while connecting to new location: %v\n", err)
			}
			return int(userLocId), nil
		}
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

	err := queries.DecrementWorkerCount(ctx, int64(locationId))
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

	err := queries.IncrementWorkerCount(ctx, int64(locationId))
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

	names, err := queries.GetTaskTypesForLocationTypeId(ctx, int64(locationTypeId))
	if err != nil {
		return names, fmt.Errorf("issue getting task names for a location by a task type id: %w", err)
	}

	return names, nil
}

// GetLocationFromLocationId gets locations made by user from a locationId
func GetLocationFromLocationId(id int) (sqlc.GetLocationByIdRow, error) {

	queries := db.GetQueries()
	ctx := context.Background()

	userLoc, err := queries.GetLocationById(ctx, int64(id))
	if err != nil {
		return userLoc, fmt.Errorf("error scanning location data from locId: %w,", err)
	}

	return userLoc, nil
}
