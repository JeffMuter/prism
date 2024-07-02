package nodes

import (
	"fmt"
	"log"
	"prism/database"
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

func CreateNode(userId int, userLong float64, userLat float64) error {
	// get all other nodes
	// if any other nodes are too close, err
	// else, create new node
	db := database.OpenDatabase()
	defer db.Close()

	var locations []Location

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
	}
	return nil
}
