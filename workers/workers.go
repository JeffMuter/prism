package workers

import (
	"fmt"
	"prism/database"
	"prism/nodes"
	"prism/user"
	"time"
)

type Worker struct {
	Id             int
	UserLocationId int
	UserId         int
	LocationId     int
	WorkStatus     bool
	InjuredStatus  bool
	Strength       int
	Faith          int
	Intelligence   int
	CreatedAt      time.Time
	Religion       string
	Age            int
	Name           string
	LocationName   string
	ArtFilName     string `default:"worker"`
	Art            nodes.Art
}

func GetWorkersRelevantToUser(user user.User) []Worker {
	var workers []Worker

	db := database.OpenDatabase()
	defer db.Close()

	query := "SELECT  workers.id, name, age, religion, work_status, injured, intelligence, strength, faith, named, user_locations.id  FROM workers LEFT JOIN user_locations ON workers.user_locations_id = user_locations.id WHERE user_id = $1"

	rows, err := db.Query(query, user.Id)
	if err != nil {
		fmt.Println("error querying: ", err)
	}
	for rows.Next() {
		var worker Worker
		rows.Scan(&worker.Id, &worker.Name, &worker.Age, &worker.Religion, &worker.WorkStatus, &worker.InjuredStatus, &worker.Intelligence, &worker.Strength, &worker.Faith, &worker.LocationName, &worker.LocationId)
		workers = append(workers, worker)
	}

	return workers
}

func GetWorkersRelatedToLocation(locationId int) []Worker {
	var workers []Worker
	query := "SELECT workers.id, name, age, religion, work_status, injured, intelligence, strength, faith, named, user_locations.id FROM workers LEFT JOIN user_locations ON workers.user_locations_id = user_locations.id WHERE location_id = $1"
	db := database.OpenDatabase()
	defer db.Close()

	rows, err := db.Query(query, locationId)
	if err != nil {
		fmt.Println("Error getting rows from query to db: ", err)
	}
	for rows.Next() {
		var worker Worker
		rows.Scan(&worker.Id, &worker.Name, &worker.Age, &worker.Religion, &worker.WorkStatus, &worker.InjuredStatus, &worker.Intelligence, &worker.Strength, &worker.Faith, &worker.LocationName, &worker.LocationId)
		workers = append(workers, worker)
	}

	return workers
}

func PrintWorkerDetails(worker Worker) {
	fmt.Println("Worker Details:")
	fmt.Printf("Name: %s | Location Name: %v | Status: %v | Intelligence: %v | Strength: %v | Faith: %v | Injuered: %v\n", worker.Name, worker.LocationName, worker.WorkStatus, worker.Intelligence, worker.Strength, worker.Faith, worker.InjuredStatus)
}

func PrintWorkersDetails(workers []Worker) {
	fmt.Println("Worker Details:")
	for i, worker := range workers {
		fmt.Printf("%v: | Name: %s | Location Name: %v | Status: %v | Intelligence: %v | Strength: %v | Faith: %v | Injuered: %v\n", i, worker.Name, worker.LocationName, worker.WorkStatus, worker.Intelligence, worker.Strength, worker.Faith, worker.InjuredStatus)
	}
}

func AssignWorkerToLocation(worker Worker, newLocation nodes.Location) error {
	// assign a worker to travel to a location
	// if they have a valid user_locations id, then we remove a worker_count from that location.
	// add a worker_count to the new location,
	// then add the user_locations.id to the worker in the db and object
	db := database.OpenDatabase()
	defer db.Close()
	var newUserLocationId int

	query := "SELECT user_locations.id FROM user_locations WHERE location_id = $1"
	row := db.QueryRow(query, newLocation.Id)
	err := row.Scan(&newUserLocationId)
	if err != nil {
		fmt.Println("err getting queryRow response converted to int: ", err)
	}

	query = "UPDATE workers SET user_locations_id = $1 WHERE workers.id = $2"

	_, err = db.Exec(query, newUserLocationId, worker.Id)
	if err != nil {
		fmt.Println("issue updating worker's user_location_id: ", err)
	}

	return nil
}

// ToggleWorkingForWorker is meant to swap the current value of worker_status,
// which indicates if they're mining materials or not.
func ToggleWorkingForWorker(worker Worker) error {
	db := database.OpenDatabase()
	defer db.Close()
	query := "UPDATE workers SET work_status = NOT work_status WHERE workers.id = $1"
	_, err := db.Exec(query, worker.Id)
	if err != nil {
		return fmt.Errorf("Error toggling worker work_status: %v", err)
	}
	var statusOfWork string
	if worker.WorkStatus {
		statusOfWork = "resting"
	} else {
		statusOfWork = "working"
	}
	fmt.Printf("%s is now %s", worker.Name, statusOfWork)
	return nil
}
