package nodes

import (
	"bufio"
	"errors"
	"fmt"
	"log"
	"os"
	"prism/database"
	"prism/user"
	"prism/util"
)

type Location struct {
	Id                int
	DefaultAccessible bool
	LocationType      string
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

	query = "INSERT INTO user_locations (user_id, location_id) VALUES ($1, $2)"
	db.QueryRow(query, user.Id, newLocationRowId)

	return nil
}

// GetAllNodesUserCouldSee used to get locations from the database, placed into a location type.
func GetAllNodesUserCouldSee(user user.User) []Location {
	var locations []Location

	db := database.OpenDatabase()
	defer db.Close()

	query :=
		"SELECT name, latitude, longitude, art FROM locations LEFT JOIN user_locations ON locations.id = user_locations.location_id WHERE user_locations.user_id = $1 OR locations.default_accessible = TRUE"

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
		var artName string = location.ArtFileName
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
	max := 0
	for _, line := range art.Art {
		if len(line) > max {
			max = len(line)
		}
	}
	art.Width = max

	return art
}

func CreateArtFromStringSlice(artSlice []string) Art {
	var thisArt = Art{Art: artSlice}
	thisArt = thisArt.UpdateArtDimensions()

	return thisArt
}

// ConnectToNode allows a user to see if they can make a new node in this location. Checks a lat/long
// range, and if no other nodes are inside it, creates the new node.
func ConnectToNode(user user.User) error {
	db := database.OpenDatabase()
	defer db.Close()

	// get all locations currently not associated to this user
	query := "SELECT locations.id, name, latitude, longitude FROM locations LEFT JOIN user_locations ON locations.id = user_locations.location_id AND user_locations.user_id = $1 WHERE user_id IS NULL"
	rows, err := db.Query(query, user.Id)
	if err != nil {
		fmt.Println("err querying db for connect to node: ", err)
	}
	// a range of roughly .1 miles in lat/long.
	minLat, maxLat, minLong, maxLong := util.GetMaxLocationRanges(.0015, user.Latitude, user.Longitude)
	var locations []Location
	for rows.Next() {
		var location Location
		err := rows.Scan(&location.Id, &location.Name, &location.Latitude, &location.Longitude)
		if err != nil {
			log.Fatal(err)
		}
		if location.Latitude < maxLat && location.Latitude > minLat && location.Longitude < maxLong && location.Longitude > minLong {
			query = "INSERT INTO user_locations (user_id, location_id) VALUES ($1, $2);"
			db.QueryRow(query, user.Id, location.Id)
			return nil
		}
		locations = append(locations, location)
	}

	return errors.New("could not find a node close enough to connect to")
}

// GetListOfNodesLinkedToUser takes a user, and returns a slice of locations, made from the db, that
// are related to that user.
func GetListOfNodesLinkedToUser(user user.User) ([]Location, error) {
	var locations []Location

	db := database.OpenDatabase()
	defer db.Close()

	query := "SELECT locations.id, worker_count, location_type, latitude, longitude, name, description, art FROM locations LEFT JOIN user_locations ON locations.id = user_locations.location_id WHERE user_locations.user_id = $1"
	rows, err := db.Query(query, user.Id)
	if err != nil {
		return locations, err
	}
	for rows.Next() {
		var location Location
		err := rows.Scan(&location.Id, &location.WorkerCount, &location.LocationType, &location.Latitude, &location.Longitude, &location.Name, &location.Description, &location.ArtFileName)
		if err != nil {
			return locations, err
		}
		locations = append(locations, location)
	}
	return locations, nil
}

// RemoveWorkerFromNode reduces worker_count value in the db by 1
func RemoveWorkerFromNode(location Location) error {
	db := database.OpenDatabase()
	defer db.Close()

	countAfter := location.WorkerCount - 1
	query := "UPDATE user_locations SET worker_count = $1 WHERE user_locations.id = $2"

	_, err := db.Exec(query, countAfter, location.Id)
	if err != nil {
		fmt.Println("Error subtracting from worker_count", err)
		return err
	}

	return nil
}

// AddWorkerToNode updates the new node in the db to increase by 1.
func AddWorkerToNode(location Location) error {
	db := database.OpenDatabase()
	defer db.Close()

	countAfter := location.WorkerCount + 1
	query := "UPDATE user_locations SET worker_count = $1 WHERE user_locations.id = $2"

	_, err := db.Exec(query, countAfter, location.Id)
	if err != nil {
		fmt.Println("Error subtracting from worker_count", err)
		return err
	}

	return nil
}

func GetTasksForLocation(location Location) ([]string, error) {
	db := database.OpenDatabase()
	defer db.Close()

	var taskTypes []string
	locationType := location.LocationType
	query := "SELECT tt.name FROM task_types tt JOIN location_types_tasks ltt ON tt.id = ltt.task_type_id JOIN location_types lt ON ltt.location_type_id = lt.id WHERE lt.name = ?;"

	rows, err := db.Query(query, locationType)
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
	query := "SELECT id, location_type, latitude, longitude, name, description, art FROM locations WHERE id = $1"

	row := db.QueryRow(query, id)

	err := row.Scan(&location.Id, &location.LocationType, &location.Latitude, &location.Longitude, &location.Name, &location.Description, &location.ArtFileName)
	if err != nil {
		return location, err
	}

	return location, nil
}
