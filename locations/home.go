package locations

import (
	"fmt"
	"prism/database"
)

func SetHomeLocation(locId int) error {

	db := database.GetDB()

	query := `UPDATE locations l (location_type_id, location_type) VALUES (10, 'home') WHERE l.id = $1`

	_, err := db.Exec(query, locId)
	if err != nil {
		return fmt.Errorf("error executing query to make loc a home type: %w,", err)
	}

	return nil
}
