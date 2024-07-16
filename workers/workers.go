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
	ArtFilName     string `default:"worker"`
	Art            nodes.Art
}

func CreateWorker() {

}

func GetWorkersRelevantToUser(user user.User) []Worker {
	var workers []Worker

	db := database.OpenDatabase()
	defer db.Close()

	query := "SELECT name FROM workers LEFT JOIN user_locations ON workers.user_locations_id = user_locations.id WHERE user_id = $1"

	rows, err := db.Query(query, user.Id)
	if err != nil {
		fmt.Println("error querying: ", err)
	}
	for rows.Next() {
		var worker Worker
		rows.Scan(&worker.Name)
		workers = append(workers, worker)
	}

	return workers
}

func GetWorkersRelatedToLocation(locationId int) []Worker {
	var workers []Worker
	query := "SELECT workers.id, name, age, religion, work_status, injured, intelligence, strength, faith FROM workers LEFT JOIN user_locations ON workers.user_locations_id = user_locations.id WHERE location_id = $1"
	db := database.OpenDatabase()
	defer db.Close()

	rows, err := db.Query(query, locationId)
	if err != nil {
		fmt.Println("Error getting rows from query to db: ", err)
	}
	for rows.Next() {
		var worker Worker
		rows.Scan(&worker.Id, &worker.Name, &worker.Age, &worker.Religion, &worker.WorkStatus, &worker.InjuredStatus, &worker.Intelligence, &worker.Strength, &worker.Faith)
		workers = append(workers, worker)
	}

	return workers
}

func PrintWorkerDetails(worker Worker) {
	fmt.Printf("Name: %s | Status: %v | Intelligence: %v | Strength: %v | Faith: %v | Injuered: %v\n", worker.Name, worker.WorkStatus, worker.Intelligence, worker.Strength, worker.Faith, worker.InjuredStatus)
}

func AssignWorkerToLocation(worker Worker, location nodes.Location, work string) error {
	// assign a worker to travel to a location
	// confirm that the type of work is possible
	//
	return nil
}
func AssignJobToWorker() {
	//
}
