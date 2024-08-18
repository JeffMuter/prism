package workers

import (
	"fmt"
	"prism/database"
	"prism/util"
	"time"
)

// AddEgg receives the user's id, and the location the egg was discovered, and creates a new egg for that user at that
// location. Returns error if process fails
func AddEgg(usersLocationsId int) error {
	db := database.OpenDatabase()
	defer db.Close()
	query := "INSERT INTO eggs (users_locations_id, discovery_time) VALUES ($1, $2);"

	_, err := db.Exec(query, usersLocationsId, time.Now())
	if err != nil {
		return fmt.Errorf("issue adding egg to db: %v\n", err)
	}
	return nil
}

// HatchEgg is a func that 'rolls' a new worker.
func HatchEgg(eggId int) error {
	// create a new worker, with randomized stats & attributes.
	var strength, intelligence, faith, luck, speed, loyalty, charisma int = util.RandParetoNum(1, 10), util.RandParetoNum(1, 10), util.RandParetoNum(1, 10), util.RandParetoNum(1, 10), util.RandParetoNum(1, 10), util.RandParetoNum(1, 10), util.RandParetoNum(1, 10)
	var religions = []string{"christian", "beastialism", "reversion"}
	var workerReligion string = religions[util.RandNumBetween(0, len(religions)-1)]

	//get name from user input
	workerName, err := util.ReadCommandInput()
	if err != nil {
		return fmt.Errorf("issue hatching egg from getting user input: %v\n", err)
	}

	db := database.OpenDatabase()
	defer db.Close()

	// get the locationId of the egg for the new worker db.
	query := "SELECT l.id FROM eggs e JOIN users_locations ul ON ul.id = e.users_locations_id JOIN locations l ON l.id = ul.location_id WHERE e.id = $1"
	var eggLocationId int
	_ = db.QueryRow(query, eggId).Scan(&eggLocationId)

	// create new worker with all the collected values
	query = "INSERT INTO workers (name, religion, strength, intelligence, speed, faith, luck, loyalty, charisma) VALUES ($1, $2, $3, $4, $5, $6, $7)"

	_, err = db.Exec(query, workerName, workerReligion, strength, intelligence, speed, faith, luck, loyalty, charisma)
	if err != nil {
		return fmt.Errorf("issue when hatching egg, executing insert: %v\n", err)
	}
	// attach worker to the location the egg is at.
	// add new worker to db.
	// remove that egg from user's

	return nil
}
