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
			"WHERE user_locations.user_id = ? OR locations.default_accessible = TRUE"

	rows, err := db.Query(query, user.Id)
	if err != nil {
		fmt.Println("err querying db for create node: ", err)
	}

	for rows.Next() {
		var location Location
		// TODO: trim this down to just grab lat & long for efficiency
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
	query = "INSERT INTO locations (default_accessible, location_type, longitude, latitude, name, description, art) VALUES ($1, $2, $3, $4, $5, $6, $7)"
	retRow := db.QueryRow(query, "false", "node", user.Latitude, user.Longitude, "new node", "new node description", "node")
	//not totally sure how to properly err handle for retRow...
	fmt.Println(retRow.Scan())
	query = "INSERT INTO user_locations (user_id, location_id) VALUES ($1, $2)"
	retRow = db.QueryRow(query)

	return nil
}
