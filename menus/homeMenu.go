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
		return fmt.Errorf("error getting locations for the location menu %w: ", err)
	}
	printables := locations.MakeLocsPrintable(userLocations, locations.SomeDetailsPrintFactory{})
	locationChosenIndex, err := util.PrintNumericSelection(printables)
	if err != nil {
		return fmt.Errorf("error finding user selected location: %w,", err)
	}

	fmt.Println("Name the center of your future empire...")

	homeName, err := util.ReadCommandInput()
	if err != nil {
		return fmt.Errorf("error could not read user input: %w,", err)
	}

	err = locations.SetHomeLocation(&userLocations[locationChosenIndex], homeName)
	if err != nil {
		fmt.Errorf("error setting home location: %w,", err)
	}

	return nil
}
