package nodes

import (
	"fmt"
	"log"
	"prism/database"
	"prism/render"
	"prism/user"
	"prism/util"
)

type Location struct {
	Id                int
	DefaultAccessible bool
	LocationType      string
	Longitude         float64
	Latitude          float64
	Name              string
	Description       string
	ArtFileName       string
	art               render.Art
	YCoordinate       int
	XCoordinate       int
}

func CreateNode(user user.User) error {
	// get all other nodes
	// if any other nodes are too close, err
	// else, create new node

	//this num signifies 10 miles in lat/long degrees. We're using this to
	// determine the max / min lat&long to determine if the node we want to place is too close to another node.
	var latLongRange float64 = 0.145

	// call func to get the vars for the lat/long range
	minLat, maxLat, minLong, maxLong := util.GetMaxLocationRanges(latLongRange, user.Latitude, user.Longitude)

	var locations []Location = GetNodesRelevantToUserFromDb(user)

	for _, loc := range locations {
		if loc.Latitude > minLat && loc.Latitude < maxLat && loc.Longitude > minLong && loc.Longitude < maxLong {
			return fmt.Errorf("node location too close to another: %s", loc.Name)
		}
	}

	db := database.OpenDatabase()
	defer db.Close()

	// add node to locations
	query := "INSERT INTO locations (default_accessible, location_type, longitude, latitude, name, description, art) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id"
	var newLocationRowId int
	db.QueryRow(query, "false", "node", user.Latitude, user.Longitude, "new node", "new node description", "node").Scan(&newLocationRowId)

	query = "INSERT INTO user_locations (user_id, location_id) VALUES ($1, $2)"
	db.QueryRow(query, user.Id, newLocationRowId)

	return nil
}

// GetNodesRelevantToUserFromDb used to get locations from the database, placed into a location type.
func GetNodesRelevantToUserFromDb(user user.User) []Location {
	var locations []Location

	db := database.OpenDatabase()
	defer db.Close()

	query :=
		"SELECT name, longitude, latitude FROM locations LEFT JOIN user_locations ON locations.id = user_locations.location_id WHERE user_locations.user_id = $1 OR locations.default_accessible = TRUE"

	rows, err := db.Query(query, user.Id)
	if err != nil {
		fmt.Println("err querying db for create node: ", err)
	}

	for rows.Next() {
		var location Location
		err := rows.Scan(&location.Name, &location.Latitude, &location.Longitude)
		if err != nil {
			log.Fatal(err)
		}
		locations = append(locations, location)
	}
	return locations
}
