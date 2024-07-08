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

func Listen() {
	reader := bufio.NewReader(os.Stdin)

	input, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("Invalid input: ", err)
	}
	input = strings.TrimSpace(input)

	if input == "ping" {
		render.PaintScreen() // repaints the screen
	} else if input == "node" {
		userLat, userLong, err := user.Ping()
		if err != nil {
			fmt.Println(err)
		}
		err = nodes.CreateNode()
		if err != nil {
			fmt.Println(err)
		}
	}
}
