package workers

import (
	"fmt"
	"prism/database"
	"prism/util"
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

// HatchEgg is a func that 'rolls' a new worker.
func HatchEgg(eggId int) error {
	// create a new worker, with randomized stats & attributes.
	var intelligence, strength, luck, loyalty, charisma int = util.RandParetoNum(1, 10), util.RandParetoNum(1, 10), util.RandParetoNum(1, 10), util.RandParetoNum(1, 10), util.RandParetoNum(1, 10)

	// attach worker to the location the egg is at.
	// add new worker to db.
	// remove that egg from user's

	return nil
}
