package menus

import (
	"fmt"
	"prism/locations"
	"prism/util"
)

func setHomeLocation(userId int) error {
	// SetHomeLocation is a func that allows the user to set an existing location to become the home location.
	userLocations, err := locations.GetLocationsForUser(userId)
	if err != nil {
		return fmt.Errorf("error getting locations for the node menu %w: ", err)
	}
	printables := locations.MakeLocsPrintable(userLocations, locations.SomeDetailsPrintFactory{})
	locationChosenIndex, err := util.PrintNumericSelection(printables)
	if err != nil {
		return fmt.Errorf("error finding user selected location: %w,", err)
	}

	err = locations.SetHomeLocation(userLocations[locationChosenIndex].UserLocationId)

	fmt.Println("home menu func hasn't been implemented yet... ", userId)
	return nil
}
