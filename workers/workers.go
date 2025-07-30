package workers

import (
	"fmt"
	"prism/db"
	"prism/locations"
	"prism/user"
	"time"
)

type Worker struct {
	Id             int
	UserLocationId int
	UserId         int
	LocationId     int
	WorkStatus     bool
	WorkType       string
	InjuredStatus  bool
	Strength       int
	Faith          int
	Intelligence   int
	CreatedAt      time.Time
	Religion       string
	Name           string
	LocationName   string
	ArtFilName     string `default:"worker"`
	Art            locations.Art
}

func GetWorkersRelevantToUser(user user.User) ([]Worker, error) {
	var workers []Worker

	db := db.GetDB()

	query := "SELECT  workers.id, name, religion, work_status, injured, intelligence, strength, faith, named, users_locations.id, users_locations.location_id  FROM workers LEFT JOIN users_locations ON workers.user_locations_id = users_locations.id WHERE user_id = ?"

	rows, err := db.Query(query, user.Id)
	if err != nil {
		return workers, fmt.Errorf("error querying db: %w\nquery: %s,", err, query)
	}
	for rows.Next() {
		var worker Worker
		err = rows.Scan(&worker.Id, &worker.Name, &worker.Religion, &worker.WorkStatus, &worker.InjuredStatus, &worker.Intelligence, &worker.Strength, &worker.Faith, &worker.LocationName, &worker.UserLocationId, &worker.LocationId)
		if err != nil {
			return workers, fmt.Errorf("error assigning vars from sql row scan: %w,", err)
		}
		workers = append(workers, worker)
	}

	return workers, nil
}

func GetWorkersRelatedToLocation(locationId int) ([]Worker, error) {
	var workers []Worker
	// complicated query,but the left joins allow us to get workers who have yet to be assigned a task ever.
	query := `SELECT
                w.id,
                w.name,
                w.religion,
                w.work_status,
                w.injured,
                w.intelligence,
                w.strength,
                w.faith,
                ul.name,
                ul.id,
                ul.user_id,
                ul.location_id,
                tt.name
                FROM workers w
                JOIN users_locations ul ON w.user_locations_id = ul.id
                RIGHT JOIN workers_tasks wt ON w.id = wt.worker_id AND wt.end_time IS NULL
                LEFT JOIN task_types tt ON wt.task_type_id = tt.id
                WHERE ul.location_id = ?;`

	db := db.GetDB()

	rows, err := db.Query(query, locationId)
	if err != nil {
		return workers, fmt.Errorf("Error getting rows from query to db: %w\nquery: %s", err, query)
	}
	for rows.Next() {
		var worker Worker
		err := rows.Scan(&worker.Id,
			&worker.Name,
			&worker.Religion,
			&worker.WorkStatus,
			&worker.InjuredStatus,
			&worker.Intelligence,
			&worker.Strength,
			&worker.Faith,
			&worker.LocationName,
			&worker.UserLocationId,
			&worker.UserId,
			&worker.LocationId,
			&worker.WorkType)
		if err != nil {
			return workers, fmt.Errorf("error scanning sql row: %w\nquery: %s,", err, query)
		}
		workers = append(workers, worker)
	}
	return workers, nil
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

// MoveWorkerToLocation assigns a worker to travel to a location, updates new location as well
func MoveWorkerToLocation(worker Worker, newLocation locations.Location) error {
	// if they have a valid user_locations id, then we remove a worker_count from that location.
	// add a worker_count to the new location,
	// then add the user_locations.id to the worker in the db and object

	db := db.GetDB()
	var newUserLocationId int

	query := "SELECT users_locations.id FROM users_locations WHERE location_id = ?"
	row := db.QueryRow(query, newLocation.Id)
	err := row.Scan(&newUserLocationId)
	if err != nil {
		fmt.Println("err getting queryRow response converted to int: ", err)
	}

	query = `UPDATE workers 
			SET user_locations_id = ? 
			WHERE workers.id = ?`

	_, err = db.Exec(query, newUserLocationId, worker.Id)
	if err != nil {
		fmt.Println("issue updating worker's user_location_id: ", err)
	}

	return nil
}

// ToggleWorkingForWorker is meant to swap the current value of worker_status,
// which indicates if they're mining materials or not.
func ToggleWorkingForWorker(worker Worker) error {

	database := db.GetDB()

	query := `UPDATE workers 
				SET work_status = NOT work_status 
				WHERE workers.id = ?`

	_, err := database.Exec(query, worker.Id)
	if err != nil {
		return fmt.Errorf("error toggling worker work_status: %v", err)
	}

	fmt.Printf("%s is now %s", worker.Name, worker.WorkStatus)

	return nil
}

func CreateWorker() {

}
