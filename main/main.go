package main

import (
	"fmt"
	"os"
	"prism/operating_system"
)

func main() {
	width, height, err := operating_system.GetTerminalSize()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}
	fmt.Printf("Width: %d, Height: %d\n", width, height)
	// for i := 0; i < width; i++ {
	// 	// one line of ascii
	// 	fmt.Println("***")
	// 	for j := 0; j < height; j++ {
	// 		// one height?
	// 	}

	// }
}
