package menus

import (
	"fmt"
	"prism/locations"
	"prism/util"
)

// gets all user locations, and allows users to choose options based on those locations
func DisplayUserLocations(userId int) error {
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
	displayWorkersAtLocation(userLocations[locationChosenIndex])

	return nil
}

func DisplayLocations(locations []locations.Location) {
	for i := range locations {
		fmt.Printf("%v | name: %v\n", i, locations[i].Name)
	}
}
