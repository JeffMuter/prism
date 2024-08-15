package eggs

import (
	"fmt"
	"prism/database"
	"time"
)

// AddEgg receives the user's id, and the location the egg was discovered, and creates a new egg for that user at that
// location. Returns error if process fails
func AddEgg(userId int, locationId int) error {
	db := database.OpenDatabase()
	defer db.Close()
	query := "INSERT INTO eggs (user_id, discovery_location_id, discovery_time) VALUES ($1, $2, $3);"

	_, err := db.Exec(query, userId, locationId, time.Now())
	if err != nil {
		return fmt.Errorf("issue adding egg to db: %v\n", err)
	}
	return nil
}
