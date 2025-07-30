package workers

import (
	"fmt"
	"prism/db"
	"prism/util"
	"time"
)

// egg object for db interraction
type Egg struct {
	Id             int
	UserLocationId int
	LocationId     int
	WorkerId       int
	DiscoveryTime  time.Time
	HatchTime      time.Time
	LocationName   string
}

// AddEgg receives the user's id, and the location the egg was discovered, and creates a new egg for that user at that
// location. Returns error if process fails
func AddEgg(usersLocationsId int) error {
	db := db.GetDB()
	query := "INSERT INTO eggs (users_locations_id, discovery_time) VALUES (?, ?);"

	_, err := db.Exec(query, usersLocationsId, time.Now())
	if err != nil {
		return fmt.Errorf("issue adding egg to db: %v\n", err)
	}
	return nil
}

// HatchEgg is a func that 'rolls' a new worker.
func HatchEgg(eggId int) error {
	// create a new worker, with randomized stats & attributes.
	var randTime = util.InitializeTime()
	var strength, intelligence, faith, luck, speed, loyalty, charisma = util.RandNormalizedNum(randTime, 1, 10), util.RandNormalizedNum(randTime, 1, 10), util.RandNormalizedNum(randTime, 1, 10), util.RandNormalizedNum(randTime, 1, 10), util.RandNormalizedNum(randTime, 1, 10), util.RandNormalizedNum(randTime, 1, 10), util.RandNormalizedNum(randTime, 1, 10)
	var religions = []string{"christian", "beastialism", "reversion"}
	var workerReligion = religions[util.RandNumBetween(util.InitializeTime(), 0, len(religions)-1)]

	//get name from user input
	fmt.Println("enter your new worker's name!")
	workerName, err := util.ReadCommandInput()
	if err != nil {
		return fmt.Errorf("issue hatching egg from getting user input: %v\n", err)
	}

	db := db.GetDB()

	// get the locationId of the egg for the new worker db.
	query := "SELECT users_locations_id FROM eggs WHERE id = ?"
	var eggUserLocationId int
	err = db.QueryRow(query, eggId).Scan(&eggUserLocationId)
	if err != nil {
		return fmt.Errorf("error selecting ul.id from this egg: %w,", err)
	}

	// create new worker with all the collected values
	query = "INSERT INTO workers (name, user_locations_id, religion, strength, intelligence, speed, faith, luck, loyalty, charisma) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?) RETURNING id;"

	var workerId int
	err = db.QueryRow(query, workerName, eggUserLocationId, workerReligion, strength, intelligence, speed, faith, luck, loyalty, charisma).Scan(&workerId)
	if err != nil {
		return fmt.Errorf("error inserting new worker: %w,", err)
	}

	// update the egg's hatched and worker_id value, so that we know the egg has hatched.
	query = "UPDATE eggs SET hatch_time = ?, worker_id = ? WHERE id = ?"
	_, err = db.Query(query, time.Now(), workerId, eggId)
	if err != nil {
		return fmt.Errorf("error updating eggs after making worker: %v\n", err)
	}

	//create a task for the new worker, give them a status of resting
	query = `INSERT INTO workers_tasks 
		(task_type_id, location_id, worker_id, start_time) 
	VALUES (?, ?, ?, ?);`

	// 6 is a hard coded id for the resting id...
	_ = db.QueryRow(query, 6, eggUserLocationId, workerId, time.Now())

	return nil
}

func GetEggsAvailableForUser(userId int) ([]Egg, error) {
	var eggs []Egg
	db := db.GetDB()
	query := "SELECT e.id, ul.named FROM eggs e JOIN users_locations ul ON ul.id = e.users_locations_id JOIN users u ON u.id = ul.user_id JOIN locations l ON ul.location_id = l.id WHERE u.id = ? AND e.worker_id IS NULL"
	rows, err := db.Query(query, userId)
	if err != nil {
		return eggs, fmt.Errorf("error selecting eggs from db: %v\n", err)
	}
	for rows.Next() {
		var egg Egg
		err = rows.Scan(&egg.Id, &egg.LocationName)
		if err != nil {
			return eggs, fmt.Errorf("error reading eggs. Current egg: %v\n eggs: %v\nErr: %v", egg, eggs, err)
		}
		eggs = append(eggs, egg)
	}

	return eggs, nil
}

func ShowEggsDetails(eggs []Egg) error {
	for i := range eggs {
		fmt.Printf(
			"Available Eggs:\n"+
				"%d: Location: %s\n", i, eggs[i].LocationName)
	}
	return nil
}
