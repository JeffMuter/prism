package menus

import (
	"fmt"
	"prism/locations"
	"prism/tasks"
	"prism/util"
	"prism/workers"
)

// DisplayWorkersAtLocation shows the user all workers at a given location, then gives them options to choose from for said workers
func displayWorkersAtLocation(loc locations.Location) (workers.Worker, error) {
	var chosenWorker workers.Worker
	fmt.Printf("loc id: %d\n", loc.Id)
	fmt.Printf("Your workers at %s:\n", loc.Named)

	locationWorkers, err := workers.GetWorkersRelatedToLocation(loc.Id)
	if err != nil {
		return chosenWorker, fmt.Errorf("error getting workers related to this location: %w\nlocationId: %d", err, loc.Id)
	}
	fmt.Println(len(locationWorkers), "len of locWorkers")
	// print workers from print func for workers.
	printables := workers.MakeWorkersPrintable(locationWorkers, workers.WorkerStateFactory{})
	chosenWorkerIndex, err := util.PrintNumericSelection(printables)
	if err != nil {
		return chosenWorker, fmt.Errorf("error printing workers & getting the selection: %w,", err)
	}

	return locationWorkers[chosenWorkerIndex], nil
}

// WorkerMenuOptions is meant to handle the input / output for the menu options when a user is making decisions
// on an isolated worker
func workerMenuOptions(userId int, worker workers.Worker) error {
	fmt.Printf("Choose an option for %s\n", worker.Name)
	userInput, err := util.ReadCommandInput()
	if err != nil {
		fmt.Println(err)
	}
	if userInput == "move" {
		fmt.Println("nPick a location to move to:")
		//display locations
		usersLocations, err := locations.GetLocationsForUser(userId)
		if err != nil {
			return fmt.Errorf("error getting user's locations: %w,", err)
		}

		printables := locations.MakeLocsPrintable(usersLocations, locations.SomeDetailsPrintFactory{})
		locationChosenIndex, err := util.PrintNumericSelection(printables)
		if err != nil {
			return fmt.Errorf("error getting user index choice for list of printed options: %w,", err)
		}

		// relate the worker to the new user_locations id
		err = workers.MoveWorkerToLocation(worker, usersLocations[locationChosenIndex])
		if err != nil {
			return fmt.Errorf("error assigning worker to a new loc: %w,", err)
		}

		// set worker task requires an updated location id.
		worker.LocationId = usersLocations[locationChosenIndex].Id

		err = tasks.SetWorkerTaskToNewTask(worker, "resting")
		if err != nil {
			return fmt.Errorf("error setting worker's new task to resting.")
		}

	} else if userInput == "assign" { // assign a worker to a new type of work
		fmt.Printf("Tasks to assign the worker %s to do:\n", worker.Name)

		location, err := locations.GetLocationFromLocationId(worker.LocationId)
		if err != nil {
			return err
		}
		// get a list of potential tasks we can do at this node.
		possibleTasks, err := tasks.GetOngoingTasksFromLocid(location.Id)
		if err != nil {
			return fmt.Errorf("error getting task names for task assignment: %w", err)
		} else if len(possibleTasks) < 1 {
			return fmt.Errorf("no tasknames returned: %w", err)
		}
		// display tasks
		//		for i, task := range taskNames {
		//			fmt.Printf("%v: %s\n", i, task)
		//		}
		//2. wait for user input.

		//		userInput, err := util.ReadNumericSelection(len(taskNames))
		//		if err != nil {
		//			fmt.Println(err)
		//		}
		// TODO: replace with printable interface solution, but now for tasks

		printables := tasks.MakeTasksPrintable(possibleTasks, tasks.NameTaskFactory{})
		chosenTaskIndex, err := util.PrintNumericSelection(printables)
		//3. using this input, we assign the worker to a new task.

		err = tasks.SetWorkerTaskToNewTask(worker, possibleTasks[chosenTaskIndex].Type)
		if err != nil {
			return err
		}
		fmt.Printf("%s is now %s-ing\n", worker.Name, possibleTasks[chosenTaskIndex].Type)

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
