package main

import (
	"fmt"
	"log"
	"prism/menuV2"
	"prism/user"
	"prism/util"
)

func main() {
	// Create a test user
	testUser := user.User{
		Id:        1,
		Username:  "testuser",
		Latitude:  40.7128,
		Longitude: -74.0060,
	}

	// Create a real input reader
	reader := util.NewStdinReader()

	fmt.Println("Testing MenuV2 Static Menu System")
	fmt.Println("==================================")

	// Run the test menu
	err := menuV2.TestMainMenuV2(testUser, reader)
	if err != nil {
		log.Fatalf("Menu test failed: %v", err)
	}
	
	fmt.Println("Menu test completed successfully!")
}