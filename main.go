package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"

	"prism/render"
	"prism/user"
)

func main() {

	// get user location

	// get objects that will be on screen
	// database.getArtForDisplay()

	// get screen size
	// term.GetTermSize

	// render the screen to display to the user
	// render.RenderScreen()

	canvas := render.PaintScreen()

	for _, line := range canvas {
		fmt.Println(string(line))
	}

	reader := bufio.NewReader(os.Stdin)

	input, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("Invalid input: ", err)
	}
	input = strings.TrimSpace(input)

	if input == "ping" {
		user.Ping()

	}

}
