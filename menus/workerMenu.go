package menus

import (
	"fmt"
	"prism/nodes"
	"prism/tasks"
	"prism/user"
	"prism/util"
	"prism/workers"
	"strconv"
)

// WorkerMenuOptions is meant to handle the input / output for the menu options when a user is making decisions
// on an isolated worker
func WorkerMenuOptions(user user.User, worker workers.Worker) error {
	userInput, err := util.ReadCommandInput()
	if err != nil {
		fmt.Println(err)
	}
	if userInput == "move" {
		// assign worker to new location
		// get locations the user can access.
		locations, err := nodes.GetListOfNodesLinkedToUser(user.Id)
		if err != nil {
			return err
		}
		// print all nodes to the screen of them to choose an index num
		DisplayNodes(locations)
		//read user input for num.
		userInput, err := util.ReadCommandInput()
		fmt.Println(err)
		if intInput, err := strconv.Atoi(userInput); err == nil && intInput < len(locations) && intInput > -1 {
			// reduce the previous location's worker_count by one
			var oldLocation = nodes.Location{Id: worker.UserLocationId}
			err := nodes.RemoveWorkerFromNode(oldLocation)
			if err != nil {
				fmt.Println("issue removing worker from node after user selected new node to send worker to: ", err)
				return err
			}
			// increase the next location's worker_count by one.
			newLocation := locations[intInput]
			err = nodes.AddWorkerToNode(newLocation)
			if err != nil {
				fmt.Println("err while adding worker to node after user selected new node to assign worker to: ", err)
			}

			// relate the worker to the new user_locations id
			err = workers.AssignWorkerToLocation(worker, locations[intInput])
			if err != nil {
				fmt.Println("err assigning worker to new location during worker menu options: ", err)
				return err
			}
		} else {
			fmt.Println("incorrect input")
		}
	} else if userInput == "assign" {
		// here we need to:
		// get location from worker.LocationId
		location, err := nodes.GetLocationFromLocationId(worker.LocationId)
		if err != nil {
			return err
		}
		// get a list of potential tasks we can do at this node.
		taskNames, err := nodes.GetTasksForLocation(location)
		if err != nil {
			return err
		}
		// display tasks
		for i, task := range taskNames {
			fmt.Printf("%v: %s\n", i, task)
		}
		//2. wait for user input.

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
