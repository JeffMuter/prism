package locations

import (
	"fmt"
	"prism/database"
)

func SetHomeLocation(locId int) error {

	db := database.GetDB()

	query := `UPDATE locations l (location_type_id) VALUES (10 WHERE l.id = $1`

	_, err := db.Exec(query, locId)
	if err != nil {
		return fmt.Errorf("error executing query to make loc a home type: %w,", err)
	}

	return nil
}

func AddHome(userLocationId int) error {
	return nil
}
