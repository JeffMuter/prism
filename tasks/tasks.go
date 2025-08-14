package tasks

import (
	"fmt"
	"prism/db"
	"prism/locations"
	"prism/workers"
	"time"
)

type Task struct {
	Id             int
	WorkerId       int
	LocationId     int
	Ongoing        bool
	Type           string
	StartLat       float64
	StartLong      float64
	EndLat         float64
	EndLong        float64
	StartTime      time.Time
	EndTime        *time.Time
	ResourcesRates map[string]float64 // map contains names of tasks as keys, and their base_rates from ttr as the float
	WorkerName     string
	Duration       int // used to calculate the num of minutes the task went on for.
}

// SetWorkerTaskToNewTask is meant to take a worker and a string, which the string should be the valid name of a task,
// and set that worker's new task
func SetWorkerTaskToNewTask(worker workers.Worker, taskType string) error {
	var verifiedTaskType string
	var verifiedTaskTypeId int

	//
	taskTypeMap, err := GetMapTaskTypeIdTaskNameFromLocationId(worker.LocationId)
	if err != nil {
		return fmt.Errorf("error getting list of tasks from loc id: %w,", err)
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
	err = endCurrentWorkerTask(worker.Id)
	if err != nil {
		return fmt.Errorf("error ending worker's (id: %d) task: %w,", worker.Id, err)
	}
	db := db.GetDB()

	// need the worker's location for details
	workerLocation, err := locations.GetLocationFromLocationId(worker.LocationId)
	if err != nil {
		return fmt.Errorf("error getting loc from the worker's id (id: %d): %w,", worker.LocationId, err)
	}

	// add new task to db
	query := "INSERT INTO workers_tasks (task_type_id, location_id, worker_id, start_time, start_longitude, start_latitude, end_longitude, end_latitude, is_ongoing) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"
	_, err = db.Exec(query, verifiedTaskTypeId, workerLocation.Id, worker.Id, time.Now().UTC(), workerLocation.Latitude, workerLocation.Longitude, workerLocation.Latitude, workerLocation.Longitude, 1)
	if err != nil {
		return fmt.Errorf("error executing query to insert a new task into tasks table: %w,", err)
	}

	return nil
}

// GetListOfTaskTypes gets a list of ALL task types from the db.
func GetListOfTaskTypes() ([]string, error) {
	query := "SELECT name FROM task_types"

	db := db.GetDB()

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

// endCurrentWorkerTask is a func to end the current task of the worker.
func endCurrentWorkerTask(workerId int) error {

	// TODO: I think we should add that the task type gets created & set to resting.

	db := db.GetDB()
	query := "UPDATE workers_tasks SET is_ongoing = 0, end_time = ? WHERE worker_id = ?"
	_, err := db.Exec(query, time.Now().UTC(), workerId)
	if err != nil {
		return fmt.Errorf("error executing query to update / end the worker's current task: %w,", err)
	}
	return nil
}

// Get ongoing tasks at a location from loc id.
func GetOngoingTasksFromLocid(locId int) ([]Task, error) {
	var ongoingTasks []Task

	db := db.GetDB()
	query := `SELECT 
		wt.id, 
		w.name, 
		tt.name, 
		wt.start_time
	FROM workers_tasks wt 
	RIGHT JOIN task_types tt ON wt.task_type_id = tt.id
	RIGHT JOIN workers w ON wt.worker_id = w.id
	WHERE wt.location_id = ? 
	AND wt.end_time IS NULL;`

	rows, err := db.Query(query, locId)
	if err != nil {
		return ongoingTasks, fmt.Errorf("error querying sql for ongoing tasks: %w\n", err)
	}

	for rows.Next() {
		var thisTask Task
		err = rows.Scan(&thisTask.Id, &thisTask.WorkerName, &thisTask.Type, &thisTask.StartTime)
		if err != nil {
			return ongoingTasks, fmt.Errorf("error scanning rows of tasks: %w\n", err)
		}
		ongoingTasks = append(ongoingTasks, thisTask)
	}

	return ongoingTasks, nil
}

// GetMapTaskTypeIdTaskNameFromLocationId gets a list of all tasks that a location has access to, by a locationId
func GetMapTaskTypeIdTaskNameFromLocationId(id int) (map[int]string, error) {
	var tasks = make(map[int]string)
	db := db.GetDB()
	query := "SELECT tt.id, tt.name FROM locations l JOIN location_types_tasks ltt ON l.location_type_id = ltt.location_type_id JOIN task_types tt ON ltt.task_type_id = tt.id WHERE l.id = ?"

	rows, err := db.Query(query, id)
	if err != nil {
		return tasks, fmt.Errorf("error querying to get task names and id's from a loc id: %w,", err)
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

// GetOngoingTaskNamesRateMapFromLocationId merely takes a location's id, and returns a map of all the names of
// resources the ongoing tasks at that location can yield, as well as the rates assigned by the task type for that resource.

func GetOngoingTaskNamesRateMapFromLocationId(locationId int) (map[string]float64, error) {
	var mapNameRate = make(map[string]float64)

	db := db.GetDB()
	query := "SELECT r.name, ttr.base_rate FROM workers_tasks wt JOIN task_types tt ON wt.task_type_id = tt.id JOIN task_types_resources ttr ON tt.id = ttr.task_type_id JOIN resources r ON ttr.resource_id = r.id WHERE wt.location_id = ? AND wt.is_ongoing = 1;"

	rows, err := db.Query(query, locationId)
	if err != nil {
		return mapNameRate, err
	}

	for rows.Next() {
		var taskName string
		var baseRate float64

		err := rows.Scan(&taskName, &baseRate)
		if err != nil {
			return mapNameRate, err
		}

		mapNameRate[taskName] = baseRate
	}

	return mapNameRate, nil
}
func SetTaskDuration(unsetTasks ...Task) []Task {
	var setTasks []Task
	for _, task := range unsetTasks {
		if task.EndTime != nil { // if end time is
			task.Duration = task.EndTime.Minute() - task.StartTime.Minute()
		} else {
			task.Duration = time.Now().Minute() - task.StartTime.Minute()
		}
		setTasks = append(setTasks, task)
	}
	return setTasks
}
