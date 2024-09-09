package locations

import (
	"fmt"
	"prism/database"
)

// SetHomeLocation(userLocationId int) handles the whole system of setting a location to be the home location... Setting location type to 'home', and adds new home to homes table
func SetHomeLocation(userLoc *Location, homeName string) error {

	db := database.GetDB()

	query := `UPDATE locations l (location_type_id) VALUES (10) WHERE l.id = $1)`

	_, err := db.Exec(query, userLoc.Id)
	if err != nil {
		return fmt.Errorf("error executing query to make loc a home type: %w,", err)
	}

	err = addHome(userLoc.UserLocationId, homeName)
	if err != nil {
		return fmt.Errorf("error adding hometo db: %w,", err)
	}

	return nil
}

func addHome(userLocationId int, homeName string) error {
	db := database.GetDB()

	query := `INSERT INTO homes (user_location_id, name) VALUES ($1, $2)`

	_, err := db.Exec(query, userLocationId, homeName)
	if err != nil {
		return fmt.Errorf("error executing query to insert new home into db: %w", err)
	}

	return nil
}
