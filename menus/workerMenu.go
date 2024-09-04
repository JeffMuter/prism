package menus

import (
	"fmt"
	"prism/locations"
	"prism/tasks"
	"prism/util"
	"prism/workers"
)

// DisplayWorkersAtLocation shows the user all workers at a given location, then gives them options to choose from for said workers
func displayWorkersAtLocation(loc locations.Location) error {
	fmt.Printf("Your workers at %s:\n", loc.Named)
	locationWorkers, err := workers.GetWorkersRelatedToLocation(loc.Id)
	if err != nil {
		return fmt.Errorf("error getting workers related to this location: %w\nlocationId: %d", err, loc.Id)
	}
	fmt.Println(len(locationWorkers), "len of locWorkers")
	// print workers from print func for workers.
	printables := workers.MakeWorkersPrintable(locationWorkers, workers.WorkerStateFactory{})
	chosenWorkerIndex, err := util.PrintNumericSelection(printables)
	if err != nil {
		return fmt.Errorf("error printing workers & getting the selection: %w,", err)
	}

	err = workerMenuOptions(locationWorkers[chosenWorkerIndex].UserId, locationWorkers[chosenWorkerIndex])

	return nil
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
		fmt.Printf("user id: %d\n", userId)
		usersLocations, err := locations.GetLocationsForUser(userId)
		if err != nil {
			return fmt.Errorf("error getting user's locations: %w,", err)
		}
		fmt.Println(len(usersLocations))

		printables := locations.MakeLocsPrintable(usersLocations, locations.SomeDetailsPrintFactory{})

		locationChosenIndex, err := util.PrintNumericSelection(printables)
		if err != nil {
			return fmt.Errorf("error getting user index choice for list of printed options: %w,", err)
		}

		// relate the worker to the new user_locations id
		err = workers.AssignWorkerToLocation(worker, usersLocations[locationChosenIndex])
		if err != nil {
			return fmt.Errorf("error assigning worker to a new loc: %w,", err)
		}

	} else if userInput == "assign" { // assign a worker to a new type of work
		fmt.Printf("Tasks to assign the worker %s to do:\n", worker.Name)

		location, err := locations.GetLocationFromLocationId(worker.LocationId)
		if err != nil {
			return err
		}
		// get a list of potential tasks we can do at this node.
		taskNames, err := locations.GetTaskNamesForLocationType(location.LocationTypeId)
		if err != nil {
			return fmt.Errorf("error getting task names for task assignment: %w", err)
		} else if len(taskNames) < 1 {
			return fmt.Errorf("no tasknames returned: %w", err)
		}
		// display tasks
		for i, task := range taskNames {
			fmt.Printf("%v: %s\n", i, task)
		}
		//2. wait for user input.

		// TODO: replace with printable interface solution, but now for tasks

		userInput, err := util.ReadNumericSelection(len(taskNames))
		if err != nil {
			fmt.Println(err)
		}
		//3. using this input, we assign the worker to a new task.
		chosenTask := taskNames[userInput]

		err = tasks.SetWorkerTaskToNewTask(worker, chosenTask)
		if err != nil {
			return err
		}
		fmt.Printf("%s is now %s-ing\n", worker.Name, chosenTask)

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
