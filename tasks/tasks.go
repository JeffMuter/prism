package tasks

import (
	"fmt"
	"prism/database"
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

	taskTypes, err := GetListOfTaskTypes()
	if err != nil {
		return err
	}
	// verify that the taskType param matches a task type in the db.
	for _, thisType := range taskTypes {
		if taskType == thisType {
			verifiedTaskType = taskType
		}
	}
	if verifiedTaskType == "" {
		return fmt.Errorf("no matching task type")
	}

	return nil
}

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

// EndWorkerTask is a func to end the current task of the worker.
func EndWorkerTask()
