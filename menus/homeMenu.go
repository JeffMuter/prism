package menus

import (
	"fmt"
	"prism/locations"
	"prism/user"
)

func homeMenuOptions(thisUser user.User) error {
	// SetHomeLocation is a func that allows the user to set an existing location to become the home location.
	userLocations, err := locations.GetLocationsForUser(thisUser.Id)
	if err != nil {
		return fmt.Errorf("homeMenuOptions err to get list of locations for user: %d, error: %w\n", thisUser.Id, err)
	}

	// TODO work on finishing this section after printable interface is implemented
	DisplayLocations(userLocations)

	return nil
}
