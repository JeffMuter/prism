package locations

import (
	"bufio"
	"errors"
	"fmt"
	"log"
	"math/rand"
	"os"
	"prism/database"
	"prism/user"
	"prism/util"
	"time"
)

type Location struct {
	Id                int
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
	Named             string
}

type resource struct {
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

func CreateNode(user user.User) error {
	//this num signifies 10 miles in lat/long degrees. We're using this to
	// determine the max / min lat&long to determine if the node we want to place is too close to another node.
	var latLongRange float64 = 0.145

	// call func to get the vars for the lat/long range
	minLat, maxLat, minLong, maxLong := util.GetMaxLocationRanges(latLongRange, user.Latitude, user.Longitude)

	var locations []Location = GetAllNodesUserCouldSee(user)

	// check each location, if any node is too close, cancel the process
	for _, loc := range locations {
		if loc.Latitude > minLat && loc.Latitude < maxLat && loc.Longitude > minLong && loc.Longitude < maxLong {
			return fmt.Errorf("node location too close to another: %s", loc.Name)
		}
	}

	db := database.OpenDatabase()
	defer db.Close()

	// add node to locations
	query := "INSERT INTO locations (default_accessible, location_type, latitude, longitude, name, description, art) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id"
	var newLocationRowId int
	db.QueryRow(query, "false", "node", user.Latitude, user.Longitude, "new node", "new node description", "node").Scan(&newLocationRowId)

	query = "INSERT INTO users_locations (user_id, location_id) VALUES ($1, $2)"
	_, err := db.Exec(query, user.Id, newLocationRowId)
	if err != nil {
		return fmt.Errorf("error inserting users_locations when creating new location: %v\n", err)
	}
	return nil
}

// GetAllNodesUserCouldSee used to get locations from the database, placed into a location type.
func GetAllNodesUserCouldSee(user user.User) []Location {
	var locations []Location

	db := database.OpenDatabase()
	defer db.Close()

	query :=
		"SELECT name, latitude, longitude, art FROM locations LEFT JOIN users_locations ON locations.id = users_locations.location_id WHERE users_locations.user_id = $1 OR locations.default_accessible = TRUE"

	rows, err := db.Query(query, user.Id)
	if err != nil {
		fmt.Println("err querying db for create node: ", err)
	}

	for rows.Next() {
		var location Location
		err := rows.Scan(&location.Name, &location.Latitude, &location.Longitude, &location.ArtFileName)
		if err != nil {
			log.Fatal(err)
		}
		locations = append(locations, location)
	}
	return locations
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
	var newLocId int
	db := database.OpenDatabase()
	defer db.Close()

	// get all locations currently not associated to this user
	query := "SELECT locations.id, name, latitude, longitude FROM locations LEFT JOIN users_locations ON locations.id = users_locations.location_id AND users_locations.user_id = $1 WHERE user_id IS NULL"
	rows, err := db.Query(query, user.Id)
	if err != nil {
		return newLocId, fmt.Errorf("err querying db for connect to node: %v", err)
	}
	// a range of roughly .1 miles in lat/long.
	minLat, maxLat, minLong, maxLong := util.GetMaxLocationRanges(.5, user.Latitude, user.Longitude)
	var locations []Location

	for rows.Next() {
		var location Location
		err := rows.Scan(&location.Id, &location.Name, &location.Latitude, &location.Longitude)
		if err != nil {
			return newLocId, fmt.Errorf("error scanning values from row in rows.next, err: %v\n", err)
		}
		if location.Latitude < maxLat && location.Latitude > minLat && location.Longitude < maxLong && location.Longitude > minLong {

			query = "INSERT INTO users_locations (user_id, location_id) VALUES ($1, $2) RETURNING id;"
			err = db.QueryRow(query, user.Id, location.Id).Scan(&newLocId)
			if err != nil {
				return newLocId, fmt.Errorf("error inserting new users_locations while connecting to new location: %v\n", err)
			}
			return newLocId, nil
		}
		locations = append(locations, location)
	}

	return newLocId, errors.New("could not find a node close enough to connect to")
}

// GetListOfNodesLinkedToUser takes a userId, and returns a slice of locations, made from the db, that
// are related to that user.
func GetListOfNodesLinkedToUser(userId int) ([]Location, error) {
	var locations []Location

	db := database.OpenDatabase()
	defer db.Close()

	query := "SELECT locations.id, worker_count, location_type, location_type_id, latitude, longitude, name, description, art FROM locations LEFT JOIN users_locations ON locations.id = users_locations.location_id WHERE users_locations.user_id = $1"
	rows, err := db.Query(query, userId)
	if err != nil {
		return locations, err
	}
	for rows.Next() {
		var location Location
		err := rows.Scan(&location.Id, &location.WorkerCount, &location.LocationType, &location.LocationTypeId, &location.Latitude, &location.Longitude, &location.Name, &location.Description, &location.ArtFileName)
		if err != nil {
			return locations, err
		}
		locations = append(locations, location)
	}
	return locations, nil
}

// RemoveWorkerFromNode reduces worker_count value in the db by 1
func RemoveWorkerFromNode(locationId int) error {

	db := database.OpenDatabase()
	defer db.Close()

	query := "UPDATE users_locations SET worker_count = worker_count - 1 WHERE users_locations.id = $1"

	_, err := db.Exec(query, locationId)
	if err != nil {
		fmt.Println("Error subtracting from worker_count", err)
		return err
	}

	return nil
}

// AddWorkerToNode updates the new node in the db to increase by 1.
func AddWorkerToNode(locationId int) error {
	db := database.OpenDatabase()
	defer db.Close()

	query := "UPDATE users_locations SET worker_count = worker_count + 1 WHERE users_locations.id = $1"

	_, err := db.Exec(query, locationId)
	if err != nil {
		fmt.Println("Error subtracting from worker_count", err)
		return err
	}

	return nil
}

// GetTasksForLocation gets all task names for a location, using the location
func GetTasksForLocation(location Location) ([]string, error) {
	db := database.OpenDatabase()
	defer db.Close()

	var taskTypes []string
	locationTypeId := location.LocationTypeId
	query := "SELECT tt.name FROM task_types tt JOIN location_types_tasks ltt ON tt.id = ltt.task_type_id JOIN location_types lt ON ltt.location_type_id = lt.id WHERE lt.id = $1"

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
	db := database.OpenDatabase()
	defer db.Close()
	query := "SELECT id, location_type, location_type_id, latitude, longitude, name, description, art FROM locations WHERE id = $1"

	row := db.QueryRow(query, id)

	err := row.Scan(&location.Id, &location.LocationType, &location.LocationTypeId, &location.Latitude, &location.Longitude, &location.Name, &location.Description, &location.ArtFileName)
	if err != nil {
		return location, err
	}

	return location, nil
}

func GetNamesForResourcesOfTasksFromLocation(id int) ([]resource, error) {

	var resources []resource

	db := database.OpenDatabase()
	defer db.Close()
	query := "SELECT r.name, ttr.base_rate FROM workers_tasks wt JOIN task_types tt ON wt.task_type_id = tt.id JOIN task_types_resources ttr ON tt.id = ttr.task_type_id JOIN resources r ON ttr.resource_id = r.id WHERE wt.location_id = $1 AND wt.is_ongoing = TRUE;"

	rows, err := db.Query(query, id)
	if err != nil {
		return resources, errors.New("failed to selects resource names from ongoing tasks related to locationId")
	}

	for rows.Next() {
		var resource resource
		err = rows.Scan(&resource.name, &resource.baseRate)
		if err != nil {
			return resources, errors.New("error scanning rows in GetResourcesFromLocationIdForUpdating")
		}
		resources = append(resources, resource)
	}

	return resources, nil
}

func GetResourceDataByLocationId(id int) ([]resource, error) {
	var resources []resource

	db := database.OpenDatabase()
	defer db.Close()
	query := "SELECT r.id, r.name, lr.quantity, lr.last_updated FROM locations_resources lr JOIN resources r ON r.id = lr.resource_id  WHERE lr.location_id = $1;"

	rows, err := db.Query(query, id)
	if err != nil {
		return resources, errors.New("issue querying db for values from getting resources by location id")
	}

	for rows.Next() {
		var resource resource
		err := rows.Scan(&resource.locationResourceId, &resource.name, &resource.quantity, &resource.lastUpdated)
		if err != nil {
			return resources, errors.New("issue assigning values from row to get resources by location id")
		}
		resources = append(resources, resource)
	}

	return resources, nil
}

// UpdateLocationResources updates the locations_resources table, for each entry of this location. Adds new rows for each resource with a value, not yet on the table
func UpdateLocationResources(locationId int, resources []resource) error {
	// remove the element if the quantity is 0 or less. If 0 or less, then we don't need to update the db with it.
	for i, resource := range resources {
		if resource.quantity < 1 {
			beforeIndex := resources[:i]
			afterIndex := resources[:i+1]
			resources = append(beforeIndex, afterIndex...)
		}
	}

	db := database.OpenDatabase()
	defer db.Close()
	query := "UPDATE locations_resources lr SET last_updated = $1, quantity = $2 WHERE location_id = $3 AND resource_id = $4;"

	for _, resource := range resources {
		_, err := db.Exec(query, resource.lastUpdated, resource.quantity, locationId, resource.locationResourceId)
		if err != nil {
			return errors.New("could not update locations_resources")
		}
	}
	return nil
}

func CreateNewResources(locationId int, resources []resource) error {
	db := database.OpenDatabase()
	defer db.Close()
	query := "INSERT INTO locations_resources (location_id, resource_id, last_updated, quantity) VALUES ($1, $2, $3, $4)"
	for i := range resources {
		err := db.QueryRow(query, locationId, resources[i].locationResourceId, resources[i].lastUpdated, resources[i].quantity)
		if err != nil {
			return fmt.Errorf("error inserting locations_resources row to db: %v", err)
		}
	}
	return nil
}

// GetResourceIdByName takes in a string which references a Resource type, and returns the id of the Resource
func GetResourceIdByName(name string) (int, error) {
	var id int = -1

	db := database.OpenDatabase()
	defer db.Close()
	query := "SELECT id FROM resources WHERE name = $1"
	row := db.QueryRow(query, name)
	err := row.Scan(&id)
	if err != nil {
		return id, errors.New("error selecting name from resources by name")
	}
	return id, nil
}

func FindMissingLocationResources(potentialResources map[string]float64, existingResources []resource) ([]resource, error) {

	var newResources []resource // for the resources that are not in the db yet, so we can add them seperately

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
				return newResources, err
			}

			// cannot leave baseRate at 0... TODO
			newResource := resource{resourceId, resourceName, time.Now().UTC(), 0, rate}
			newResources = append(newResources, newResource)
		}
	}
	return newResources, nil
}

// CalculateEarnings taking in the number of minutes passed, and a list of resources
func CalculateEarnings(resourcesWithMinutes map[resource]int) []resource {
	r := rand.New(rand.NewSource(time.Now().UnixNano()))
	var resources []resource
	for resource, minutes := range resourcesWithMinutes {
		for i := 0; i < minutes; i++ {
			if r.Float64() < resource.baseRate {
				resource.quantity++
			}
		}
		resources = append(resources, resource)
	}

	return resources
}

func CalculateMinutesPassedFromLastUpdate(resources []resource) map[resource]int {
	var mapResourceMin = make(map[resource]int)
	now := time.Now().UTC()

	for _, resource := range resources {
		timePassed := now.Sub(resource.lastUpdated)
		resource.lastUpdated = now // now done calc minutes since last update, set new time for this loc_res
		mapResourceMin[resource] = int(timePassed.Minutes())
	}
	return mapResourceMin
}

func AddRatesToResourcesFromMapResourceNameRate(resources []resource, mapResourceRate map[string]float64) []resource {
	for i := range resources {
		resources[i].baseRate = mapResourceRate[resources[i].name]
	}
	return resources
}
