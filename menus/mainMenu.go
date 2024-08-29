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
	reader := bufio.NewReader(os.Stdin)

	input, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("Invalid input: ", err)
	}
	input = strings.TrimSpace(input)

	if input == "ping" {
		render.PaintScreen(thisUser) // repaints the screen
	} else if input == "new location" {
		thisUser.Latitude, thisUser.Longitude, err = user.Ping()
		if err != nil {
			fmt.Println(err)
		}
		err = locations.CreateLocation(thisUser)
		if err != nil {
			fmt.Println(err)
		}
	} else if input == "connect" {
		newLocId, err := locations.ConnectToLocation(thisUser)
		if err != nil {
			fmt.Println("Issue connecting to node: ", err)
		}
		err = workers.AddEgg(newLocId)
		if err != nil {
			fmt.Println(fmt.Errorf("issue adding egg: %v", err))
		}
	} else if input == "locations" {
		DisplayUserLocations(thisUser)
	} else if input == "eggs" {
		err = EggMenuOptions(thisUser)
		if err != nil {
			return fmt.Errorf("issue with egg menu: %v", err)
		}
		// uncomment this when the home options is working, else err
		//	} else if input == "home" {
		//		err = homeMenuOptions()
		//		if err != nil {
		//			fmt.Println(fmt.Errorf("error from home menu in main menu: %v\n", err))
		//		}
	}
	return nil
}
