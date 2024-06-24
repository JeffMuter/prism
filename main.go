package main

import (
	"fmt"

	"prism/render"
)

func main() {

	// get user location

	// get objects that will be on screen
	// database.getArtForDisplay()

	// get screen size
	// term.GetTermSize

	// render the screen to display to the user
	// render.RenderScreen()

	canvas := render.RenderScreen()

	for _, line := range canvas {
		fmt.Println(string(line))
	}

}
