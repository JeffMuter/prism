package menus

import (
	"fmt"
	"prism/locations"
	"prism/user"
	"prism/util"
	"prism/workers"
	"strconv"
)

func DisplayUserLocations(user user.User) {
	// get a list of locations
	userLocations, err := locations.GetListOfNodesLinkedToUser(user.Id)
	if err != nil {
		fmt.Println("error getting locations for the node menu: ", err)
	}
	// display info on each node.
	for i := range userLocations {
		fmt.Printf("%v | name: %v\n", i, userLocations[i].Name)
	}
	// implement new print concept via interfaces.
	util.PrintNumericSelection(locations.MakeLocsPrintable(userLocations))

	// listen for input
	locationMenuListen(user, userLocations)
}

func DisplayLocations(locations []locations.Location) {
	for i := range locations {
		fmt.Printf("%v | name: %v\n", i, locations[i].Name)
	}
}

func locationMenuListen(user user.User, locations []locations.Location) {
	userInput, err := util.ReadCommandInput()
	if err != nil {
		fmt.Println("error with getting user input.", err)
	}

	// if user input's a string within the length of the slice index, then we know they're correctly looking
	//for more info on a particular location
	if intInput, err := strconv.Atoi(userInput); err == nil && intInput < len(locations) && intInput > -1 {
		// get a list of workers for this node.
		workerSlice := workers.GetWorkersRelatedToLocation(locations[intInput].Id)
		// display contents
		fmt.Printf("Name: %s | WorkerCount: %v | Type: %v| Longitude: %v | Latitude: %v\n", locations[intInput].Name, locations[intInput].WorkerCount, locations[intInput].LocationType, locations[intInput].Longitude, locations[intInput].Latitude)

		workers.PrintWorkersDetails(workerSlice)
		userInput, err = util.ReadCommandInput()
		if err != nil {
			fmt.Println("issue reading uer input.", err)
		}

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
