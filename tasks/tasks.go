package tasks

import (
	"errors"
	"fmt"
	"prism/database"
	"prism/nodes"
	"prism/workers"
	"time"
)

type Task struct {
	TaskId     int
	WorkerId   int
	LocationId int
	Ongoing    bool
	Type       string
	StartLat   float64
	StartLong  float64
	EndLat     float64
	EndLong    float64
	StartTime  time.Time
	EndTime    time.Time
}

// SetWorkerTaskToResting func is meant to take a worker, and set their task to resting, ending their old task at the
// same time.
func SetWorkerTaskToResting(worker workers.Worker) error {
	return nil
}

// SetWorkerTaskToNewTask is meant to take a worker and a string, which the string should be the valid name of a task,
// and set that worker's new task
func SetWorkerTaskToNewTask(worker workers.Worker, taskType string) error {
	var verifiedTaskType string
	var verifiedTaskTypeId int

	//
	taskTypeMap, err := GetListOfTasksFromLocationId(worker.LocationId)
	if err != nil {
		return err
	}
	// verify that the taskType param matches a task type in the db.
	for id, thisType := range taskTypeMap {
		if taskType == thisType {
			verifiedTaskType = taskType
			verifiedTaskTypeId = id
		}
	}
	if verifiedTaskType == "" {
		return fmt.Errorf("no matching task type")
	}

	//end the old task
	err = EndCurrentWorkerTask(worker)
	if err != nil {
		return err
	}
	db := database.OpenDatabase()
	defer db.Close()

	// need the worker's location for details
	workerLocation, err := nodes.GetLocationFromLocationId(worker.LocationId)
	if err != nil {
		return err
	}

	// add new task to db
	query := "INSERT INTO workers_tasks (task_type_id, location_id, worker_id, start_time, start_longitude, start_latitude, end_longitude, end_latitude, is_ongoing) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)"
	_, err = db.Exec(query, verifiedTaskTypeId, workerLocation.Id, worker.Id, time.Now(), workerLocation.Latitude, workerLocation.Longitude, workerLocation.Latitude, workerLocation.Longitude, true)
	if err != nil {
		return err
	}

	return nil
}

// GetListOfTaskTypes gets a list of ALL task types from the db.
func GetListOfTaskTypes() ([]string, error) {
	query := "SELECT name FROM task_types"

	db := database.OpenDatabase()
	defer db.Close()

	var taskTypes []string

	rows, err := db.Query(query)
	if err != nil {
		return taskTypes, err
	}

	for rows.Next() {
		var taskType string
		err := rows.Scan(&taskType)
		if err != nil {
			return taskTypes, err
		}
		taskTypes = append(taskTypes, taskType)
	}
	return taskTypes, nil
}

// EndCurrentWorkerTask is a func to end the current task of the worker.
func EndCurrentWorkerTask(worker workers.Worker) error {
	db := database.OpenDatabase()
	defer db.Close()
	query := "UPDATE workers_tasks SET is_ongoing = false, end_time = $1 WHERE worker_id = $2"
	_, err := db.Exec(query, time.Now(), worker.Id)
	if err != nil {
		return err
	}
	return nil
}

// GetListOfTasksFromLocationId gets a list of all tasks that a location has access to, by a locationId
func GetListOfTasksFromLocationId(id int) (map[int]string, error) {
	var tasks = make(map[int]string)
	db := database.OpenDatabase()
	defer db.Close()
	query := "SELECT tt.id, tt.name FROM locations l JOIN location_types_tasks ltt ON l.location_type_id = ltt.location_type_id JOIN task_types tt ON ltt.task_type_id = tt.id WHERE l.id = $1"

	rows, err := db.Query(query, id)
	if err != nil {
		return tasks, err
	}

	for rows.Next() {
		var taskName string
		var taskTypeId int

		err := rows.Scan(&taskTypeId, &taskName)
		if err != nil {
			return tasks, err
		}

		tasks[taskTypeId] = taskName
	}

	return tasks, nil
}

// GetOngoingTasksFromLocation func takes in an id, and spits out all associated tasks.
func GetOngoingTasksFromLocation(id int) ([]task, error) {
	var tasks []Task

	db := database.OpenDatabase()
	defer db.Close()
	query := "SELECT task_type_id FROM workers_tasks wt JOIN WHERE location_id = $1 AND is_ongoing = TRUE"

	rows, err := db.Query(query, id)
	if err != nil {
		return tasks, errors.New("failed to selects tasks by locationId")
	}

	for rows.Next() {
		var thisTask Task
		rows.Scan()
	}

	return tasks, nil
}
