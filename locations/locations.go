package locations

import (
	"bufio"
	"errors"
	"fmt"
	"os"
	"prism/database"
	"prism/user"
	"prism/util"
	"time"
)

type Location struct {
	Id                int
	UserLocationId    int
	DefaultAccessible bool
	LocationType      string
	LocationTypeId    int
	Latitude          float64
	Longitude         float64
	Name              string
	Description       string
	ArtFileName       string
	Art               Art
	YCoordinate       int
	XCoordinate       int
	WorkerCount       int
	name              string
	Resources         []Resource
}

type Resource struct {
	locationResourceId int
	name               string
	lastUpdated        time.Time
	quantity           int
	baseRate           float64
}

type Art struct {
	Width  int
	Height int
	Art    []string
}

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

	db := database.GetDB()

	// add node to locations
	query := `INSERT INTO locations 
		(default_accessible, latitude, longitude, name, description, art, location_type_id) 
	VALUES ($1, $2, $3, $4, $5, $6, $7, $8) 
	RETURNING id`
	// TODO: cannot be using all these lame hard coded values here...
	db.QueryRow(query, "false", user.Latitude, user.Longitude, locName, "new node description", "node", locTypeId).Scan(&newLocationRowId)

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

	db := database.GetDB()

	query := `SELECT ul.name, l.latitude, l.longitude, l.art 
	FROM locations l 
	LEFT JOIN users_locations ul ON l.id = ul.location_id 
	WHERE ul.name IS NOT NULL 
	AND (
	ul.user_id = $1 
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

// SetLocationsArt send the name of the .txt file, returns slice of strings to represent an objects art.
func SetLocationsArt(locations []Location) []Location {
	var locationsWithArt []Location
	for _, location := range locations {
		// we want to take the path, go to our assets folder
		var artSlice []string
		var artName = location.ArtFileName
		txtFilePath, err := util.GetAbsoluteFilepath("/assets/" + artName + ".txt")
		if err != nil {
			fmt.Println("txtFilePath err:", txtFilePath, err)
		}
		// get file
		file, err := os.Open(txtFilePath)
		if err != nil {
			fmt.Println(err)
		}
		defer file.Close()

		// create scanner to read the file
		scanner := bufio.NewScanner(file)

		// read lines of txt file.
		for scanner.Scan() {
			artSlice = append(artSlice, scanner.Text())
		}

		// check for scanning errors
		if err := scanner.Err(); err != nil {
			fmt.Println(err)
		}

		// make an Art struct from the slice of strings, set it to location
		location.Art = CreateArtFromStringSlice(artSlice)

		// add this location to the locations slice.
		locationsWithArt = append(locationsWithArt, location)
	}
	return locationsWithArt
}

// UpdateArtDimensions takes in an art object, and adds the dimension fields of height and width
func (art Art) UpdateArtDimensions() Art {
	art.Height = len(art.Art)
	maximum := 0
	for _, line := range art.Art {
		if len(line) > maximum {
			maximum = len(line)
		}
	}
	art.Width = maximum

	return art
}

func CreateArtFromStringSlice(artSlice []string) Art {
	var thisArt = Art{Art: artSlice}
	thisArt = thisArt.UpdateArtDimensions()

	return thisArt
}

// ConnectToLocation allows a user to see if they can make a new node in this location. Checks a lat/long
// range, and if no other locations are inside it, creates the new node. Returns the id of the newly connected location.
func ConnectToLocation(user user.User) (int, error) {
	var newUsersLocsId int
	db := database.GetDB()

	// get all locations currently not associated to this user
	query := `SELECT locations.id, name, latitude, longitude 
	FROM locations 
	LEFT JOIN users_locations ON locations.id = users_locations.location_id 
	AND users_locations.user_id = $1 
	WHERE user_id IS NULL`
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
func GetLocationsForUser(userId int) ([]Location, error) {
	var locations []Location

	db := database.GetDB()

	fmt.Println(userId)
	query := `SELECT 
		l.id, 
		ul.id
		ul.worker_count, 
		l.location_type_id, 
		l.latitude, 
		l.longitude, 
		l.description, 
		l.art, 
		ul.name,
		lt.name
	FROM locations l
	JOIN users_locations ul ON l.id = ul.location_id 
	JOIN location_types lt ON l.location_type_id = lt.id
	WHERE ul.user_id = $1;
`

	rows, err := db.Query(query, userId)
	if err != nil {
		return locations, fmt.Errorf("error querying db for locations: %w", err)
	}
	for rows.Next() {
		var location Location
		err := rows.Scan(&location.Id, &location.UserLocationId, &location.WorkerCount, &location.LocationTypeId, &location.Latitude, &location.Longitude, &location.Description, &location.ArtFileName, &location.Name, &location.LocationType)
		if err != nil {
			return locations, fmt.Errorf("error scanning sql row: %w", err)
		}
		locations = append(locations, location)
	}
	return locations, nil
}

// RemoveWorkerFromNode reduces worker_count value in the db by 1
func RemoveWorkerFromNode(locationId int) error {

	db := database.GetDB()

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
	db := database.GetDB()

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
	db := database.GetDB()

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
	var location Location
	db := database.GetDB()
	query := `SELECT id, location_type_id, latitude, longitude, name, description, art 
	FROM locations 
	WHERE id = $1`

	row := db.QueryRow(query, id)

	err := row.Scan(&location.Id, &location.LocationTypeId, &location.Latitude, &location.Longitude, &location.Name, &location.Description, &location.ArtFileName)
	if err != nil {
		return location, err
	}

	return location, nil
}

func GetNamesForResourcesOfTasksFromLocation(id int) ([]Resource, error) {

	var resources []Resource

	db := database.GetDB()
	query := `SELECT r.name, ttr.base_rate 
	FROM workers_tasks wt 
	JOIN task_types tt ON wt.task_type_id = tt.id 
	JOIN task_types_resources ttr ON tt.id = ttr.task_type_id 
	JOIN resources r ON ttr.resource_id = r.id 
	WHERE wt.location_id = $1 
	AND wt.is_ongoing = TRUE;`

	rows, err := db.Query(query, id)
	if err != nil {
		return resources, errors.New("failed to selects resource names from ongoing tasks related to locationId")
	}

	for rows.Next() {
		var resource Resource
		err = rows.Scan(&resource.name, &resource.baseRate)
		if err != nil {
			return resources, errors.New("error scanning rows in GetResourcesFromLocationIdForUpdating")
		}
		resources = append(resources, resource)
	}

	return resources, nil
}

// GetResourceDataByLocationId takes a location id as an int, and fills all the fields of a resource, returning a slice of them.
func GetResourceDataByLocationId(locId int) ([]Resource, error) {
	var resources []Resource

	db := database.GetDB()
	query := `SELECT r.id, r.name, lr.quantity, lr.last_updated 
	FROM locations_resources lr 
	JOIN resources r ON r.id = lr.resource_id 
	WHERE lr.location_id = $1;`

	rows, err := db.Query(query, locId)
	if err != nil {
		return resources, errors.New("issue querying db for values from getting resources by location id")
	}

	for rows.Next() {
		var resource Resource
		err := rows.Scan(&resource.locationResourceId, &resource.name, &resource.quantity, &resource.lastUpdated)
		if err != nil {
			return resources, fmt.Errorf("error scanning resource fields from row: %w,", err)
		}
		resources = append(resources, resource)
	}

	return resources, nil
}

// UpdateLocationResources updates the locations_resources table, for each entry of this location. Adds new rows for each resource with a value, not yet on the table
func UpdateLocationResources(locationId int, resources []Resource) error {
	// remove the element if the quantity is 0 or less. If 0 or less, then we don't need to update the db with it.
	for i, resource := range resources {
		if resource.quantity < 1 {
			beforeIndex := resources[:i]
			afterIndex := resources[:i+1]
			resources = append(beforeIndex, afterIndex...)
		}
	}

	db := database.GetDB()
	query := `UPDATE locations_resources lr 
	SET last_updated = $1, quantity = $2 
	WHERE location_id = $3 
	AND resource_id = $4;`

	for _, resource := range resources {
		_, err := db.Exec(query, resource.lastUpdated, resource.quantity, locationId, resource.locationResourceId)
		if err != nil {
			return fmt.Errorf("could not update locations_resources: %w,", err)
		}
	}
	return nil
}

// CreateNewResources takes a loc id, and a slice of resources, and iinserts them into the db on locations_resources table, using fields of the resource to populate the db info. Specifically to only be used on new resources that currently don't exist for this locations
func CreateNewResources(locationId int, resources []Resource) error {
	db := database.GetDB()
	query := `INSERT INTO locations_resources 
	(location_id, resource_id, last_updated, quantity) 
	VALUES ($1, $2, $3, $4)`
	for i := range resources {
		_, err := db.Exec(query, locationId, resources[i].locationResourceId, resources[i].lastUpdated, resources[i].quantity)
		if err != nil {
			return fmt.Errorf("error inserting locations_resources row to db: %w", err)
		}
	}
	return nil
}

// GetResourceIdByName takes in a string which references a Resource type, and returns the id of the Resource
func GetResourceIdByName(name string) (int, error) {
	var id = 0

	db := database.GetDB()
	query := `SELECT id 
	FROM resources 
	WHERE name = $1`
	row := db.QueryRow(query, name)
	err := row.Scan(&id)
	if err != nil {
		return id, fmt.Errorf("error scanning sql row while getting resource id from name string: %w,", err)
	}
	return id, nil
}

// FindMissingLocationResources()
func FindMissingLocationResources(potentialResources map[string]float64, existingResources []Resource) ([]Resource, error) {

	var newResources []Resource // for the resources that are not in the db yet, so we can add them seperately

	// we need to make resources, for each potential resource not currently in resource slice.
	for resourceName, rate := range potentialResources {
		var found bool
		for _, resource := range existingResources {
			if resource.name == resourceName {
				found = true
				break
			}
		}
		if !found { // if not found, make an add a new resource to the slice of existing.
			var resourceId int
			resourceId, err := GetResourceIdByName(resourceName)
			if err != nil {
				return newResources, fmt.Errorf("error getting a resource's Id by using its name (name: %s): %w,", resourceName, err)
			}

			// cannot leave baseRate at 0... TODO
			newResource := Resource{resourceId, resourceName, time.Now().UTC(), 0, rate}
			newResources = append(newResources, newResource)
		}
	}
	return newResources, nil
}

// CalculateEarnings taking in the number of minutes passed, and a list of resources
func CalculateEarnings(resourcesWithMinutes map[Resource]int) []Resource {
	randTime := util.InitializeTime()
	var resources []Resource
	for resource, minutes := range resourcesWithMinutes {
		for i := 0; i < minutes; i++ {
			if randTime.Float64() < resource.baseRate {
				resource.quantity++
			}
		}
		resources = append(resources, resource)
	}

	return resources
}

func CalculateMinutesPassedFromLastUpdate(resources []Resource) map[Resource]int {

	var mapResourceMin = make(map[Resource]int)
	now := time.Now().UTC()

	for _, resource := range resources {
		timePassed := now.Sub(resource.lastUpdated)
		resource.lastUpdated = now // now done calc minutes since last update, set new time for this loc_res
		mapResourceMin[resource] = int(timePassed.Minutes())
	}
	return mapResourceMin
}

// AddRatesToResourcesFromMapResourceNameRate is a func that takes resources, and a map of resource name & rate of generation, and applies those to a resource, returning the corresponding slice
func AddRatesToResourcesFromMapResourceNameRate(resources []Resource, mapResourceRate map[string]float64) []Resource {
	for i := range resources {
		resources[i].baseRate = mapResourceRate[resources[i].name]
	}
	return resources
}

// SetResourceDetailsForLocations() func takes any num of Location type, and sets the resources for that Location, returning them as a slice.
func SetResourceDetailsForLocations(locs ...*Location) ([]Location, error) {
	var setLocs []Location

	for _, loc := range locs {
		locResources, err := GetResourceDataByLocationId(loc.Id)
		if err != nil {
			return setLocs, fmt.Errorf("error setting resources for loc (locId: %d): %w,", loc.Id, err)
		}
		loc.Resources = locResources
	}

	return setLocs, nil
}

// SetLocResources()
func SetLocResources(loc *Location, recs []Resource) error {
	loc.Resources = recs
	return nil
}
