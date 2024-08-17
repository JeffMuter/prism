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
func MainMenuListen(thisUser user.User) {
	reader := bufio.NewReader(os.Stdin)

	input, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("Invalid input: ", err)
	}
	input = strings.TrimSpace(input)

	if input == "ping" {
		render.PaintScreen(thisUser) // repaints the screen
	} else if input == "new node" {
		thisUser.Latitude, thisUser.Longitude, err = user.Ping()
		if err != nil {
			fmt.Println(err)
		}
		err = locations.CreateNode(thisUser)
		if err != nil {
			fmt.Println(err)
		}
	} else if input == "connect" {
		newLocId, err := locations.ConnectToLocation(thisUser)
		if err != nil {
			fmt.Println("Issue connecting to node: ", err)
		}
		err = workers.AddEgg(thisUser.Id, newLocId)
		if err != nil {
			fmt.Println(fmt.Errorf("issue adding egg: %v", err))
		}
	} else if input == "locations" {
		DisplayUserNodes(thisUser)
	}
}
