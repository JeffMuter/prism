package menus

import (
	"fmt"
	"prism/nodes"
	"prism/user"
	"prism/util"
	"prism/workers"
	"strconv"
)

// WorkerMenuOptions is meant to handle the input / output for the menu options when a user is making decisions
// on an isolated worker
func WorkerMenuOptions(user user.User, worker workers.Worker) error {
	userInput := util.ReadUserInput()
	if userInput == "move" {
		// assign worker to new location
		// get locations the user can access.
		locations, err := nodes.GetListOfNodesLinkedToUser(user)
		if err != nil {
			return err
		}
		// print all nodes to the screen of them to choose an index num
		DisplayNodes(locations)
		//read user input for num.
		userInput := util.ReadUserInput()
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