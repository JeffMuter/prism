package input

import (
	"bufio"
	"fmt"
	"os"
	"prism/nodes"
	"prism/render"
	"prism/user"
	"strings"
)

func Listen(thisUser user.User) {
	reader := bufio.NewReader(os.Stdin)

	input, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("Invalid input: ", err)
	}
	input = strings.TrimSpace(input)

	if input == "ping" {
		render.PaintScreen(thisUser) // repaints the screen
	} else if input == "node" {
		thisUser.Latitude, thisUser.Longitude, err = user.Ping()
		if err != nil {
			fmt.Println(err)
		}
		err = nodes.CreateNode(thisUser)
		if err != nil {
			fmt.Println(err)
		}
	} else if input == "connect" {
		err = nodes.ConnectToNode(thisUser)
		if err != nil {
			fmt.Println("Issue connecting to node: ", err)
		}
	}
}
