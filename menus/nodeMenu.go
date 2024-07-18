package menus

import (
	"fmt"
	"prism/nodes"
	"prism/user"
	"prism/util"
	"prism/workers"
	"strconv"
)

func DisplayUserNodes(user user.User) {
	// get a list of locations
	locations, err := nodes.GetListOfNodesLinkedToUser(user)
	if err != nil {
		fmt.Println("error getting locations for the node menu: ", err)
	}
	// display info on each node.
	for i := range locations {
		fmt.Printf("%v | name: %v\n", i, locations[i].Name)
	}
	// listen for input
	nodeMenuListen(locations)
}

func DisplayNodes(locations []nodes.Location) {
	for i := range locations {
		fmt.Printf("%v | name: %v\n", i, locations[i].Name)
	}
}

func nodeMenuListen(locations []nodes.Location) {
	userInput := util.ReadUserInput()

	// if user input's a string within the length of the slice index, then we know they're correctly looking
	//for more info on a particular location
	if intInput, err := strconv.Atoi(userInput); err == nil && intInput < len(locations) && intInput > -1 {
		// get a list of workers for this node.
		workerSlice := workers.GetWorkersRelatedToLocation(locations[intInput].Id)
		// display contents
		fmt.Printf("Name: %s | WorkerCount: %v | Type: %v| Longitude: %v | Latitude: %v\n", locations[intInput].Name, locations[intInput].WorkerCount, locations[intInput].LocationType, locations[intInput].Longitude, locations[intInput].Latitude)

		workers.PrintWorkersDetails(workerSlice)
		userInput = util.ReadUserInput()

		// if user selected a num, then let's print that worker.
		if intInput, err := strconv.Atoi(userInput); err == nil && intInput < len(workerSlice) && intInput > -1 {
			workers.PrintWorkerDetails(workerSlice[intInput])
		}
		err := WorkerMenuOptions(user, workerSlice[intInput])
		if err != nil {
			fmt.Println("error with worker menu options: ", err)
		}
	} else if err == nil {
		fmt.Println("incorrect search for a worker")
	}
	return
}
