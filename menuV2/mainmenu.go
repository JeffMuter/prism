package menuV2

import (
	"fmt"
	"prism/db"
	"prism/locations"
	"prism/render"
	"prism/user"
	"prism/util"
	"prism/workers"
	"strings"
)

// LocationType represents a location type from the database
type LocationType struct {
	ID   int
	Name string
}

// getLocationTypes retrieves location types from the database
func getLocationTypes() ([]LocationType, error) {
	database := db.GetDB()
	query := "SELECT id, name FROM location_types WHERE id > 1 ORDER BY name" // Exclude 'node' type
	
	rows, err := database.Query(query)
	if err != nil {
		return nil, fmt.Errorf("error querying location types: %w", err)
	}
	defer rows.Close()
	
	var locationTypes []LocationType
	for rows.Next() {
		var lt LocationType
		err := rows.Scan(&lt.ID, &lt.Name)
		if err != nil {
			return nil, fmt.Errorf("error scanning location type: %w", err)
		}
		locationTypes = append(locationTypes, lt)
	}
	
	return locationTypes, nil
}

// CreateLocationTypeMenu creates the location type selection menu
func CreateLocationTypeMenu() (*SimpleMenu, error) {
	locationTypes, err := getLocationTypes()
	if err != nil {
		return nil, fmt.Errorf("error getting location types: %w", err)
	}
	
	var options []Option
	for _, lt := range locationTypes {
		// Create a closure to capture the location type ID
		locTypeId := lt.ID
		options = append(options, Option{
			Name:        lt.Name,
			Description: fmt.Sprintf("Create a %s location", lt.Name),
			Action: func(params ...interface{}) ([]string, error) {
				if len(params) < 3 {
					return []string{}, fmt.Errorf("requires user, reader, and location name parameters")
				}
				
				thisUser, ok := params[0].(user.User)
				if !ok {
					return []string{}, fmt.Errorf("first parameter must be user.User")
				}
				
				_, ok = params[1].(util.InputReader)
				if !ok {
					return []string{}, fmt.Errorf("second parameter must be util.InputReader")
				}
				
				locName, ok := params[2].(string)
				if !ok {
					return []string{}, fmt.Errorf("third parameter must be location name string")
				}
				
				// Get user's current location
				var err error
				thisUser.Latitude, thisUser.Longitude, err = user.Ping()
				if err != nil {
					return []string{}, fmt.Errorf("error pinging user loc: %w", err)
				}
				
				// Create the location
				usersLocsId, err := locations.CreateLocation(thisUser, locName, locTypeId)
				if err != nil {
					fmt.Printf("Error: %v\n", err)
					fmt.Print("Press any key to continue...")
					GetInput()
					return []string{"mainMenu"}, nil
				}
				
				// Add egg (warn if fails but don't fail the whole operation)
				err = workers.AddEgg(usersLocsId)
				if err != nil {
					fmt.Printf("Warning: Location created successfully, but failed to add egg: %v\n", err)
					fmt.Printf("You can manually add eggs later from the locations menu.\n")
				}
				
				fmt.Printf("Successfully created %s location: %s\n", lt.Name, locName)
				fmt.Print("Press any key to continue...")
				GetInput()
				return []string{"mainMenu"}, nil
			},
		})
	}
	
	return &SimpleMenu{
		Title:   "SELECT LOCATION TYPE",
		Options: options,
		BackFunction: func(routeStack []string) ([]string, error) {
			// Go back to main menu
			return []string{"mainMenu"}, nil
		},
	}, nil
}

// Action functions for main menu options

func PingAction(params ...interface{}) ([]string, error) {
	if len(params) < 1 {
		return []string{}, fmt.Errorf("ping requires user parameter")
	}
	thisUser, ok := params[0].(user.User)
	if !ok {
		return []string{}, fmt.Errorf("first parameter must be user.User")
	}
	
	fmt.Println("updating your location...")
	render.PaintScreen(&thisUser)
	fmt.Print("Press any key to continue...")
	GetInput()
	return []string{"mainMenu"}, nil
}

func NewLocationAction(params ...interface{}) ([]string, error) {
	if len(params) < 2 {
		return []string{}, fmt.Errorf("new location requires user and reader parameters")
	}
	_, ok := params[0].(user.User)
	if !ok {
		return []string{}, fmt.Errorf("first parameter must be user.User")
	}
	reader, ok := params[1].(util.InputReader)
	if !ok {
		return []string{}, fmt.Errorf("second parameter must be util.InputReader")
	}

	fmt.Println("What will the name of this location be?...")
	locName, err := reader.ReadCommandInput()
	if err != nil {
		return []string{}, fmt.Errorf("error getting input from the user: %w", err)
	}
	
	// Validate location name is not empty
	if locName == "" {
		fmt.Println("Location name cannot be empty!")
		fmt.Print("Press any key to continue...")
		GetInput()
		return []string{"mainMenu"}, nil
	}

	// Navigate to location type selection menu, passing the location name as context
	return []string{"mainMenu", "locationTypeMenu:" + locName}, nil
}

func ConnectAction(params ...interface{}) ([]string, error) {
	if len(params) < 1 {
		return []string{}, fmt.Errorf("connect requires user parameter")
	}
	thisUser, ok := params[0].(user.User)
	if !ok {
		return []string{}, fmt.Errorf("first parameter must be user.User")
	}

	fmt.Println("connecting to any nearby locations...")
	newLocId, err := locations.ConnectToLocation(thisUser)
	if err != nil {
		return []string{}, fmt.Errorf("error connecting to loc: %w", err)
	}
	
	err = workers.AddEgg(newLocId)
	if err != nil {
		return []string{}, fmt.Errorf("error adding egg: %w", err)
	}

	fmt.Print("Press any key to continue...")
	GetInput()
	return []string{"mainMenu"}, nil
}

func LocationsAction(params ...interface{}) ([]string, error) {
	if len(params) < 1 {
		return []string{}, fmt.Errorf("locations requires user parameter")
	}
	_, ok := params[0].(user.User)
	if !ok {
		return []string{}, fmt.Errorf("first parameter must be user.User")
	}

	// Navigate to locations grid menu
	return []string{"mainMenu", "locationsGrid"}, nil
}

func EggsAction(params ...interface{}) ([]string, error) {
	if len(params) < 1 {
		return []string{}, fmt.Errorf("eggs requires user parameter")
	}
	_, ok := params[0].(user.User)
	if !ok {
		return []string{}, fmt.Errorf("first parameter must be user.User")
	}

	fmt.Println("getting a list of your existing eggs:")
	// Note: This will call the old menu system temporarily
	return []string{"mainMenu", "eggsMenu"}, nil
}

func CreateHomeAction(params ...interface{}) ([]string, error) {
	if len(params) < 1 {
		return []string{}, fmt.Errorf("create home requires user parameter")
	}
	_, ok := params[0].(user.User)
	if !ok {
		return []string{}, fmt.Errorf("first parameter must be user.User")
	}

	fmt.Println("Select a location to make into your home:")
	// This would need the setHomeLocation function
	fmt.Print("Press any key to continue...")
	GetInput()
	return []string{"mainMenu"}, nil
}

// Back function for main menu
func MainMenuBackAction(routeStack []string) ([]string, error) {
	// Main menu goes back to map (clear route stack)
	fmt.Println("Returning to Map...")
	return []string{}, nil
}

// CreateMainMenuV2 creates the v2 version of the main menu
func CreateMainMenuV2() *SimpleMenu {
	return &SimpleMenu{
		Title: "MAIN MENU",
		Options: []Option{
			{
				Name:        "Ping",
				Description: "Update your current location",
				Action:      PingAction,
			},
			{
				Name:        "New Location",
				Description: "Create a new location at your current position",
				Action:      NewLocationAction,
			},
			{
				Name:        "Connect",
				Description: "Connect to nearby locations",
				Action:      ConnectAction,
			},
			{
				Name:        "Locations",
				Description: "View and manage your locations",
				Action:      LocationsAction,
			},
			{
				Name:        "Eggs",
				Description: "Manage your eggs",
				Action:      EggsAction,
			},
			{
				Name:        "Create Home",
				Description: "Set a location as your home",
				Action:      CreateHomeAction,
			},
		},
		BackFunction: MainMenuBackAction,
	}
}

// MainMenuListenV2 is the v2 replacement for menus.MainMenuListen
// It has the same signature so it can be a drop-in replacement
func MainMenuListenV2(thisUser user.User, reader util.InputReader) error {
	var currentMenu *SimpleMenu
	routeStack := []string{"mainMenu"} // Start with main menu

	for {
		// Determine which menu to show based on route stack
		if len(routeStack) == 0 {
			// Back to map, exit
			fmt.Println("Exiting menu system...")
			break
		}
		
		lastRoute := routeStack[len(routeStack)-1]
		
		if lastRoute == "mainMenu" {
			currentMenu = CreateMainMenuV2()
		} else if strings.HasPrefix(lastRoute, "locationTypeMenu:") {
			// Extract location name from route
			locName := strings.TrimPrefix(lastRoute, "locationTypeMenu:")
			locationTypeMenu, err := CreateLocationTypeMenu()
			if err != nil {
				return fmt.Errorf("error creating location type menu: %w", err)
			}
			
			// Modify each option to include the location name parameter
			for i := range locationTypeMenu.Options {
				originalAction := locationTypeMenu.Options[i].Action
				locationTypeMenu.Options[i].Action = func(params ...interface{}) ([]string, error) {
					// Add location name as third parameter
					newParams := append(params, locName)
					return originalAction(newParams...)
				}
			}
			
			currentMenu = locationTypeMenu
		} else if lastRoute == "locationsGrid" {
			// Show locations grid menu
			locationsGrid, err := CreateLocationsGridMenu(thisUser.Id)
			if err != nil {
				return fmt.Errorf("error creating locations grid menu: %w", err)
			}
			
			newRouteStack, err := locationsGrid.Show(routeStack, thisUser, reader)
			if err != nil {
				return fmt.Errorf("locations grid error: %w", err)
			}
			
			// Update route stack and continue
			routeStack = newRouteStack
			continue
		} else {
			currentMenu = CreateMainMenuV2()
		}

		newRouteStack, err := currentMenu.Show(routeStack, thisUser, reader)
		if err != nil {
			return fmt.Errorf("menu error: %w", err)
		}
		
		// Update route stack
		routeStack = newRouteStack
	}
	
	return nil
}

// TestMainMenuV2 allows testing the new menu system
func TestMainMenuV2(thisUser user.User, reader util.InputReader) error {
	var currentMenu *SimpleMenu
	routeStack := []string{"mainMenu"} // Start with main menu
	
	fmt.Println("Welcome to Prism V2 Menu System")
	fmt.Print("Press any key to continue...")
	GetInput()

	for {
		// Determine which menu to show based on route stack
		if len(routeStack) == 0 {
			fmt.Println("Returned to map!")
			break
		}
		
		lastRoute := routeStack[len(routeStack)-1]
		
		if lastRoute == "mainMenu" {
			currentMenu = CreateMainMenuV2()
		} else if strings.HasPrefix(lastRoute, "locationTypeMenu:") {
			// Extract location name from route
			locName := strings.TrimPrefix(lastRoute, "locationTypeMenu:")
			locationTypeMenu, err := CreateLocationTypeMenu()
			if err != nil {
				return fmt.Errorf("error creating location type menu: %w", err)
			}
			
			// Modify each option to include the location name parameter
			for i := range locationTypeMenu.Options {
				originalAction := locationTypeMenu.Options[i].Action
				locationTypeMenu.Options[i].Action = func(params ...interface{}) ([]string, error) {
					// Add location name as third parameter
					newParams := append(params, locName)
					return originalAction(newParams...)
				}
			}
			
			currentMenu = locationTypeMenu
		} else if lastRoute == "locationsGrid" {
			// Show locations grid menu
			locationsGrid, err := CreateLocationsGridMenu(thisUser.Id)
			if err != nil {
				return fmt.Errorf("error creating locations grid menu: %w", err)
			}
			
			newRouteStack, err := locationsGrid.Show(routeStack, thisUser, reader)
			if err != nil {
				return fmt.Errorf("locations grid error: %w", err)
			}
			
			// Update route stack and continue
			routeStack = newRouteStack
			fmt.Printf("Current route: %v\n", routeStack)
			continue
		} else {
			currentMenu = CreateMainMenuV2()
		}

		newRouteStack, err := currentMenu.Show(routeStack, thisUser, reader)
		if err != nil {
			return fmt.Errorf("menu error: %w", err)
		}
		
		// Update route stack
		routeStack = newRouteStack
		
		fmt.Printf("Current route: %v\n", routeStack)
	}
	
	return nil
}