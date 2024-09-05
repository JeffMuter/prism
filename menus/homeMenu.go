package menus

import (
	"fmt"
	"prism/user"
)

// TODO: let's make sure we're using the whole user as well.
func homeMenuOptions(thisUser user.User) error {
	// SetHomeLocation is a func that allows the user to set an existing location to become the home location.
	//	userLocations, err := locations.GetLocationsForUser(thisUser.Id)
	//	if err != nil {
	//		return fmt.Errorf("homeMenuOptions err to get list of locations for user: %d, error: %w\n", thisUser.Id, err)
	//	}

	// printable locations for the next steps

	fmt.Println("home menu func hasn't been implemented yet... ", thisUser.Id)
	return nil
}
