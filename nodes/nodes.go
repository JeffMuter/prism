package nodes

import "prism/database"

type Location sctruct {
	Id int
	LocationType string
	Longitude   float64
	Latitude    float64
	Name        string
	Description string
	Art         string
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

	return nil
}
