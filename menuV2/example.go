package menuV2

import (
	"fmt"
)

// Example function that simulates Ping()
func Ping(params ...interface{}) ([]string, error) {
	fmt.Println("Pinging server...")
	fmt.Println("Server responded: PONG!")
	fmt.Print("Press any key to continue...")
	GetInput()
	return []string{"mainMenu"}, nil
}

// Example function that simulates viewing locations
func ViewLocations(params ...interface{}) ([]string, error) {
	fmt.Println("Loading locations...")
	fmt.Println("Available locations:")
	fmt.Println("  1. Iron Mine")
	fmt.Println("  2. Wheat Field")
	fmt.Println("  3. Forest")
	fmt.Print("Press any key to continue...")
	GetInput()
	return []string{"mainMenu", "locationsMenu"}, nil
}

// Example function for settings
func Settings(params ...interface{}) ([]string, error) {
	fmt.Println("Opening settings...")
	fmt.Print("Press any key to continue...")
	GetInput()
	return []string{"mainMenu", "settingsMenu"}, nil
}

// Example back function
func MainMenuBack(routeStack []string) ([]string, error) {
	// Main menu should go back to map (clear route stack)
	return []string{}, nil
}

// CreateExampleMenu demonstrates how to use the SimpleMenu
func CreateExampleMenu() *SimpleMenu {
	return &SimpleMenu{
		Title: "MAIN MENU",
		Options: []Option{
			{
				Name:        "Ping Server",
				Description: "Test connection to server",
				Action:      Ping,
			},
			{
				Name:        "View Locations",
				Description: "Browse available locations",
				Action:      ViewLocations,
			},
			{
				Name:        "Settings",
				Description: "Configure game settings",
				Action:      Settings,
			},
		},
		BackFunction: MainMenuBack,
	}
}

// RunExample shows how the menu system works
func RunExample() {
	menu := CreateExampleMenu()
	routeStack := []string{}
	
	fmt.Println("Simple Menu Example")
	fmt.Println("This demonstrates the menuV2 simple menu system")
	fmt.Print("Press any key to continue...")
	GetInput()

	for {
		newRouteStack, err := menu.Show(routeStack)
		if err != nil {
			fmt.Printf("Error: %v\n", err)
			break
		}
		
		// Update route stack
		routeStack = newRouteStack
		
		// If route stack is empty, we're back to map
		if len(routeStack) == 0 {
			fmt.Println("Returned to map!")
			break
		}
		
		// For demo purposes, show the current route stack
		fmt.Printf("Current route: %v\n", routeStack)
		fmt.Print("Press any key to continue...")
		GetInput()
	}
}