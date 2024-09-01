package menus

import (
	"bufio"
	"fmt"
	"os"
	"prism/locations"
	"prism/render"
	"prism/user"
	"prism/workers"
	"strings"
)

// MainMenuListen listens for user input from the main screen
// user makes choices about the next action to take in the game,
// either with maps, or accessing other menus
func MainMenuListen(thisUser user.User) error {
	fmt.Println("Welcome to Prism. Choose a command to begin:")
	reader := bufio.NewReader(os.Stdin)

	input, err := reader.ReadString('\n')
	if err != nil {
		return fmt.Errorf("error reading input: %w", err)
	}
	input = strings.TrimSpace(input)

	if input == "ping" {
		fmt.Println("getting you location...")
		render.PaintScreen(thisUser) // repaints the screen
	} else if input == "new location" {
		fmt.Println("attempting to create a new location...")
		thisUser.Latitude, thisUser.Longitude, err = user.Ping()
		if err != nil {
			return fmt.Errorf("error pinging user loc: %w,", err)
		}
		err = locations.CreateLocation(thisUser)
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
		err = DisplayUserLocations(thisUser) // this obviously needs an error here
		if err != nil {
			return fmt.Errorf("error displaying user locations: %w,", err)
		}
	} else if input == "eggs" {
		fmt.Println("getting a list of your existing eggs:")
		err = EggMenuOptions(thisUser)
		if err != nil {
			return fmt.Errorf("issue with egg menu: %w", err)
		}
		// uncomment this when the home options is working, else err
		//	} else if input == "home" {
		//		err = homeMenuOptions()
		//		if err != nil {
		//			fmt.Println(fmt.Errorf("error from home menu in main menu: %v\n", err))		//		}
	} else {
		return fmt.Errorf("invalid input: %s,", input)
	}
	return nil
}
