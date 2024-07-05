package nodes

import (
	"fmt"
	"log"
	"prism/database"
	"prism/user"
	"prism/util"
)

type Location struct {
	Id           int
	LocationType string
	Longitude    float64
	Latitude     float64
	Name         string
	Description  string
	Art          string
}

func CreateNode(user user.User) error {
	// get all other nodes
	// if any other nodes are too close, err
	// else, create new node

	// max lat & long

	db := database.OpenDatabase()
	defer db.Close()

	var locations []Location

	//this num signifies 10 miles in lat/long degrees. We're using this to
	// determine the max / min lat&long to determine if the node we want to place is too close to another node.
	var latLongRange float64 = 0.145

	// call func to get the vars for the lat/long range
	minLat, maxLat, minLong, maxLong := util.GetMaxLocationRanges(latLongRange, user.Latitude, user.Longitude)

	query :=
		"SELECT * " +
			"FROM locations " +
			"LEFT JOIN user_locations ON locations.id = user_locations.location_id" +
			"WHERE user_locations.user_id = ? AND (user_locations.visible = TRUE OR location.location_type = 'user')" +
			"UNION" +
			"SELECT * " +
			"FROM locations " +
			"JOIN global_locations ON locations.id = global_locations.location_id" +
			"LEFT JOIN user_locations ON locations.id = user_locations.location_id AND user_locations.user_id" +
			"WHERE global_locations.available_on_start = TRUE OR user_locations.visible = TRUE" +
			");"

	rows, err := db.Query(query, userId)
	if err != nil {
		fmt.Println("err querying db for create node: ", err)
	}

	for rows.Next() {
		var location Location
		err := rows.Scan(&location.Id, &location.LocationType, &location.Longitude, &location.Latitude, &location.Name, &location.Description, &location.Art)
		if err != nil {
			log.Fatal(err)
		}
		locations = append(locations, location)
	}
	for _, loc := range locations {
		fmt.Printf("ID: %d, Type: %s, Name: %s, Description: %s\n", loc.Id, loc.LocationType, loc.Name, loc.Description)
		if loc.Latitude < minLat || loc.Latitude > maxLat || loc.Longitude < minLong || loc.Longitude > maxLong {
			return fmt.Errorf("node location too close to another")
		}
	}

	// add node to locations
	query = "INSERT INTO locations (location_type, longitude, latitude, name, description, art) VALUES ('default', $1, $2, name, 'a small default type node', 'node')"

	return nil
}
