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

	// top line, 50 char long
	for i := 0; i < 50; i++ {
		fmt.Print("*")
	}

	//make new line
	// 1 * , 48 spaces, 1 * , repeat for 20 lines
	for i := 0; i < 18; i++ {
		fmt.Println()
		fmt.Print("*")

		for j := 0; j < 48; j++ {
			if j == 23 && i == 9 {
				fmt.Print("@")
			} else {
				fmt.Print(" ")
			}
		}

		fmt.Print("*")
	}
	fmt.Println()

	// bottom line, 50 char long
	for i := 0; i < 50; i++ {
		fmt.Print("*")
	}
}
