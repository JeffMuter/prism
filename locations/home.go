package locations

import (
	"fmt"
	"prism/db"
)

// SetHomeLocation(userLocationId int) handles the whole system of setting a location to be the home location... Setting location type to 'home', and adds new home to homes table
func SetHomeLocation(userLoc *Location, homeName string) error {
	if !userLoc.IsUserCreated {
		fmt.Println("this location is not a location you created, and cannot become your 'home' location...")
		return fmt.Errorf("error this location is a global location, and its location type cannot be changed")
	}

	db := db.GetDB()

	// this can't occur like this.
	query := `UPDATE locations l SET location_type_id = 10 WHERE l.id = $1`

	_, err := db.Exec(query, userLoc.Id)
	if err != nil {
		return fmt.Errorf("error executing query to make loc a home type: %w,", err)
	}

	query = `UPDATE users_locations ul SET name= $1 WHERE ul.location_id= $2`

	_, err = db.Exec(query, homeName, userLoc.Id)

	err = addHome(userLoc.UserLocationId, homeName)
	if err != nil {
		return fmt.Errorf("error adding home to db: %w,", err)
	}

	return nil
}

func addHome(userLocationId int, homeName string) error {
	db := db.GetDB()

	query := `INSERT INTO homes (user_location_id, name) VALUES ($1, $2)`

	_, err := db.Exec(query, userLocationId, homeName)
	if err != nil {
		return fmt.Errorf("error executing query to insert new home into db: %w", err)
	}

	return nil
}
