package main

import (
	"errors"
	"fmt"
	"os"
	"prism/operating_system"
)

func main() {

	// data setup for obj location
	scrWidth := 50
	scrHeight := 18

	var userLat float32 = 32.234
	var userLong float32 = -48.554

	var objLat float32 = 33.01
	var objLong float32 = -47.935

	objCoordinates, err := findObjectCoordinate(userLong, userLat, objLong, objLat, scrWidth, scrHeight)
	if err != nil {
		fmt.Println(err)
	}

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

	// for one line, not the top / bottom of the map
	for i := 0; i < 18; i++ {
		fmt.Println()
		fmt.Print("*")

		for j := 0; j < 48; j++ {
			if j == 23 && i == 9 {
				fmt.Print("@")
			} else if j == objCoordinates[0] && i == objCoordinates[1] {
				fmt.Print("X")
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
	fmt.Println()
}

func findObjectCoordinate(userLong, userLat, objLong, objLat float32, scrWidth, scrHeight int) ([2]int, error) {

	var objPosition = [2]int{1, 1}
	latDistance := userLat - objLat
	longDistance := userLong - objLong

	if latDistance > 1 || latDistance < -1 || longDistance > 1 || longDistance < -1 {
		// if true, will NOT be visible on screen
		return objPosition, errors.New(" object too far to project to map")
	}

	// make them flip their value, so we can use the distance values where the user is at 0,0 coordinates
	latDistance *= -1
	longDistance *= -1

	// gets the range between 0-2 for the equation below
	latDistance += 1
	longDistance += 1

	var horizontalDistancePerChar float32 = float32(2) / float32(scrWidth)
	var verticalDistancePerChar float32 = float32(2) / float32(scrHeight)

	// Calculate the position in screen coordinates
	objPosition[0] = int(latDistance / horizontalDistancePerChar)
	objPosition[1] = scrHeight - int(longDistance/verticalDistancePerChar)

	fmt.Println(objPosition)
	return objPosition, nil
}
