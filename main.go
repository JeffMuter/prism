package main

import (
	"fmt"
	"log"
	"prism/db"
	"prism/menuV2"
	"prism/user"
	"prism/util"
)

func main() {

	err := db.OpenDatabase()
	if err != nil {
		log.Fatalf("db connections failed...: %v", err)
	}

	var thisUser = user.User{
		Id:       1,
		Username: "1",
		Email:    "1@gmail.com",
		Password: "1",
	}

	// Set initial location (will be updated in the map loop)
	thisUser.Latitude, thisUser.Longitude, err = user.Ping()
	if err != nil {
		fmt.Printf("Warning: Could not get location via Ping(): %v\n", err)
		fmt.Println("Using default location (40.7128, -74.0060) - NYC")
		thisUser.Latitude = 40.7128
		thisUser.Longitude = -74.0060
	}

	fmt.Printf("Location: %.6f, %.6f\n", thisUser.Latitude, thisUser.Longitude)

	// Create stdin reader for production use
	reader := util.NewStdinReader()

	// Create map controller and start the game loop
	mapController := menuV2.NewMapController(thisUser, reader)
	err = mapController.ShowMapAndListen()

	if err != nil {
		fmt.Println(fmt.Errorf("error in game: %v", err))
	} else {
		fmt.Println("Game closed...")
	}
}
