package menus

import (
	"fmt"
	"prism/locations"
	"prism/render"
	"prism/user"
	"prism/util"
	"prism/workers"
	"strings"
)

// MainMenuListen listens for user input from the main screen
// user makes choices about the next action to take in the game,
// either with maps, or accessing other menus
func MainMenuListen(thisUser user.User) error {
	fmt.Println("Welcome to Prism. Choose a command to begin:")

	input, err := util.ReadCommandInput()
	if err != nil {
		return fmt.Errorf("error reading input: %w", err)
	}
	input = strings.TrimSpace(input)

	if input == "ping" {
		fmt.Println("updating your location...")
		render.PaintScreen(thisUser) // repaints the screen
	} else if input == "new location" {
		fmt.Println("What will the name of this location be?...")
		locName, err := util.ReadCommandInput()
		if err != nil {
			return fmt.Errorf("error getting input from the user: %w,", err)
		}
		// TODO: add geolocation based location type determination & options.

		// TODO: select a loc type... just completely fake it for now.
		locTypeMap := map[string]int{
			"mine":   2,
			"farm":   3,
			"lumber": 4,
		}
		for key := range locTypeMap {
			fmt.Println(key)
		}
		fmt.Println("select a type of location to make...")
		locTypeName, err := util.ReadCommandInput()
		if err != nil {
			return fmt.Errorf("error reading user input: %w,", err)
		}

		thisUser.Latitude, thisUser.Longitude, err = user.Ping()
		if err != nil {
			return fmt.Errorf("error pinging user loc: %w,", err)
		}

		err = locations.CreateLocation(thisUser, locName, locTypeMap[locTypeName])
		if err != nil {
			return fmt.Errorf("error creating location: %w,", err)
		}
	} else if input == "connect" {
		fmt.Println("connecting to any nearby locations...")
		newLocId, err := locations.ConnectToLocation(thisUser)
		if err != nil {
			return fmt.Errorf("error connecting to loc: %w,", err)
		}
		err = workers.AddEgg(newLocId)
		if err != nil {
			return fmt.Errorf("error adding egg: %w,", err)
		}
	} else if input == "locations" {
		fmt.Println("printing nearby locations")
		err = LocationMenu(thisUser.Id)
		if err != nil {
			return fmt.Errorf("error displaying user locations: %w,", err)
		}
	} else if input == "eggs" {
		fmt.Println("getting a list of your existing eggs:")
		err = EggMenuOptions(thisUser)
		if err != nil {
			return fmt.Errorf("issue with egg menu: %w", err)
		}
	} else if input == "create home" {
		fmt.Println("Select a location to make into your home:")
		err = setHomeLocation(thisUser.Id)
		if err != nil {
			return fmt.Errorf("error turning a location into home type: %w", err)
		}
	} else {
		return fmt.Errorf("invalid input: %s,", input)
	}
	return nil
}
