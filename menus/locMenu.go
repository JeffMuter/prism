package menus

import (
	"fmt"
	"prism/locations"
	"prism/util"
)

// gets all user locations, and allows users to choose options based on those locations
func LocationMenu(userId int) error {
	userLocations, err := locations.GetLocationsForUser(userId)
	if err != nil {
		return fmt.Errorf("error getting locations for the node menu %w: ", err)
	}

	for i := range userLocations {
		recs, err := locations.GetResourceDataByLocationId(userLocations[i].Id)
		if err != nil {
			return fmt.Errorf("error could not get resources related to locId (locId: %d): %w,", userLocations[i].Id, err)
		}
		userLocations[i].Resources = recs
	}
	// TODO: pseudo: need to display these with resources. Currently just the name & detail
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
