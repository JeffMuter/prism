package menus

import (
	"fmt"
	"prism/locations"
	"prism/util"
)

// gets all user locations, and allows users to choose options based on those locations
func LocationMenu(userId int) error {
	// get a list of locations
	userLocations, err := locations.GetLocationsForUser(userId)
	if err != nil {
		return fmt.Errorf("error getting locations for the node menu %w: ", err)
	}

	// display info on each node.
	printables := locations.MakeLocsPrintable(userLocations, locations.SomeDetailsPrintFactory{})
	locationChosenIndex, err := util.PrintNumericSelection(printables)
	if err != nil {
		return fmt.Errorf("error finding user selected location: %w,", err)
	}
	// call worker menu here, pass in the location
	chosenWorker, err := displayWorkersAtLocation(userLocations[locationChosenIndex])
	if err != nil {
		return fmt.Errorf("error displaying workers at this loc (locId: %d): %w,", userLocations[locationChosenIndex].Id, err)
	}

	err = workerMenuOptions(userId, chosenWorker)
	if err != nil {
		return fmt.Errorf("error from the worker (workerId: %d) menu options: %w,", chosenWorker.Id, err)
	}

	return nil
}
