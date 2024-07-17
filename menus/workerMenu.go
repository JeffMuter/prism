package menus

import (
	"fmt"
	"prism/util"
	"prism/workers"
)

// DisplayDetailedWorker takes in a worker, and prints out all the details you'd want about a worker.
func DisplayDetailedWorker(worker workers.Worker) error {

	return nil
}

// WorkerMenuOptions is meant to handle the input / output for the menu options when a user is making decisions
// on an isolated worker
func WorkerMenuOptions(worker workers.Worker) error {
	userInput := util.ReadUserInput()
	if userInput == "move" {
		// option to assign worker to new location

	} else if userInput == "swap" {
		err := workers.ToggleWorkingForWorker(worker)
		if err != nil {
			return err
		}
	} else {
		return fmt.Errorf("incorrect input for an error: %v", userInput)
	}
	return nil
}
