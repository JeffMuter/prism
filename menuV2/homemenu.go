package menuV2

import (
	"fmt"
	"sort"
	"strings"
	"prism/locations"
	"prism/util"
)

// HomeEligibleLocationsDataSource implements DataSource for home-eligible location data
type HomeEligibleLocationsDataSource struct {
	userId       int
	allData      []interface{}
	filteredData []interface{}
}

// NewHomeEligibleLocationsDataSource creates a data source for home-eligible locations
func NewHomeEligibleLocationsDataSource(userId int) (*HomeEligibleLocationsDataSource, error) {
	return &HomeEligibleLocationsDataSource{
		userId: userId,
	}, nil
}

// GetData implements DataSource interface for home-eligible locations
func (hlds *HomeEligibleLocationsDataSource) GetData(filters map[string]interface{}, sortColumn string, sortDir SortDirection) ([]interface{}, error) {
	userLocations, err := locations.GetLocationsForUser(hlds.userId)
	if err != nil {
		return nil, fmt.Errorf("error getting locations for user: %w", err)
	}

	// Filter to only user-created locations (eligible for home conversion)
	var eligibleLocations []locations.Location
	for _, loc := range userLocations {
		if loc.IsUserCreated {
			eligibleLocations = append(eligibleLocations, loc)
		}
	}

	// Convert []Location to []interface{}
	var data []interface{}
	for _, loc := range eligibleLocations {
		data = append(data, loc)
	}
	hlds.allData = data

	// Apply filters
	filteredData := hlds.applyFilters(data, filters)

	// Apply sorting
	sortedData := hlds.applySorting(filteredData, sortColumn, sortDir)

	hlds.filteredData = sortedData
	return sortedData, nil
}

// GetTotal returns total number of home-eligible locations
func (hlds *HomeEligibleLocationsDataSource) GetTotal() int {
	return len(hlds.filteredData)
}

// applyFilters applies filtering logic to home-eligible location data
func (hlds *HomeEligibleLocationsDataSource) applyFilters(data []interface{}, filters map[string]interface{}) []interface{} {
	if len(filters) == 0 {
		return data
	}

	var filtered []interface{}
	for _, item := range data {
		loc := item.(locations.Location)
		include := true

		// Check each filter
		for column, filterValue := range filters {
			switch column {
			case "Name":
				// Fuzzy search on name
				searchTerm := strings.ToLower(filterValue.(string))
				locationName := strings.ToLower(loc.Name.String)
				if !strings.Contains(locationName, searchTerm) {
					include = false
					break
				}
			case "Type":
				// Exact match on location type
				if loc.LocationType != filterValue.(string) {
					include = false
					break
				}
			}
		}

		if include {
			filtered = append(filtered, item)
		}
	}

	return filtered
}

// applySorting applies sorting logic to home-eligible location data
func (hlds *HomeEligibleLocationsDataSource) applySorting(data []interface{}, sortColumn string, sortDir SortDirection) []interface{} {
	if sortDir == SortNone || sortColumn == "" {
		return data
	}

	// Create a copy to sort
	sorted := make([]interface{}, len(data))
	copy(sorted, data)

	// Sort based on column and direction
	sort.Slice(sorted, func(i, j int) bool {
		loc1 := sorted[i].(locations.Location)
		loc2 := sorted[j].(locations.Location)

		switch sortColumn {
		case "#":
			if sortDir == SortHighToLow {
				return loc1.Id > loc2.Id
			} else {
				return loc1.Id < loc2.Id
			}
		case "Workers":
			if sortDir == SortHighToLow {
				return loc1.WorkerCount > loc2.WorkerCount
			} else {
				return loc1.WorkerCount < loc2.WorkerCount
			}
		case "Name":
			if sortDir == SortHighToLow {
				return loc1.Name.String > loc2.Name.String
			} else {
				return loc1.Name.String < loc2.Name.String
			}
		}
		return false
	})

	return sorted
}

// handleHomeLocationRowSelection handles when a user selects a location for home conversion
func handleHomeLocationRowSelection(selectedItem interface{}, routeStack []string, params ...interface{}) ([]string, error) {
	loc, ok := selectedItem.(locations.Location)
	if !ok {
		return routeStack, fmt.Errorf("selected item is not a location")
	}

	if len(params) < 2 {
		return routeStack, fmt.Errorf("home location selection requires user and reader parameters")
	}

	reader, ok := params[1].(util.InputReader)
	if !ok {
		return routeStack, fmt.Errorf("second parameter must be util.InputReader")
	}

	// Create home name entry menu
	nameEntryMenu, err := CreateHomeNameEntryMenu(loc)
	if err != nil {
		return routeStack, fmt.Errorf("error creating home name entry menu: %w", err)
	}

	// Show the name entry menu
	_, err = nameEntryMenu.Show(routeStack, reader)
	if err != nil {
		return routeStack, fmt.Errorf("error in home name entry: %w", err)
	}

	// Return to main menu after completion
	return []string{"mainMenu"}, nil
}

// CreateHomeEligibleLocationsGridMenu creates a grid menu for selecting home-eligible locations
func CreateHomeEligibleLocationsGridMenu(userId int) (*GridMenu, error) {
	// Create data source
	dataSource, err := NewHomeEligibleLocationsDataSource(userId)
	if err != nil {
		return nil, fmt.Errorf("error creating home-eligible locations data source: %w", err)
	}

	// Get location types for filter options
	locationTypes, err := getLocationTypes()
	if err != nil {
		return nil, fmt.Errorf("error getting location types: %w", err)
	}

	var typeOptions []string
	for _, lt := range locationTypes {
		typeOptions = append(typeOptions, lt.Name)
	}

	// Define columns (same as regular locations grid)
	columns := []Column{
		{
			Name:  "#",
			Type:  NumericColumn,
			Width: 5,
			Accessor: func(data interface{}) string {
				loc := data.(locations.Location)
				return fmt.Sprintf("%d", loc.Id)
			},
		},
		{
			Name:  "Name",
			Type:  TextColumn,
			Width: 25,
			Accessor: func(data interface{}) string {
				loc := data.(locations.Location)
				return loc.Name.String
			},
		},
		{
			Name:    "Type",
			Type:    SelectColumn,
			Width:   15,
			Options: typeOptions,
			Accessor: func(data interface{}) string {
				loc := data.(locations.Location)
				return loc.LocationType
			},
		},
		{
			Name:  "Workers",
			Type:  NumericColumn,
			Width: 8,
			Accessor: func(data interface{}) string {
				loc := data.(locations.Location)
				return fmt.Sprintf("%d", loc.WorkerCount)
			},
		},
	}

	// Create grid menu with 10 items per page
	gridMenu := NewGridMenu("SELECT LOCATION FOR HOME", columns, dataSource, 10)

	// Set the row selection callback
	gridMenu.OnRowSelect = handleHomeLocationRowSelection

	return gridMenu, nil
}

// CreateHomeNameEntryMenu creates a menu for entering the home name
func CreateHomeNameEntryMenu(loc locations.Location) (*SimpleMenu, error) {
	options := []Option{
		{
			Name:        "Enter Home Name",
			Description: "Name the center of your future empire",
			Action: func(params ...interface{}) ([]string, error) {
				if len(params) < 1 {
					return []string{}, fmt.Errorf("home name entry requires reader parameter")
				}

				reader, ok := params[0].(util.InputReader)
				if !ok {
					return []string{}, fmt.Errorf("first parameter must be util.InputReader")
				}

				// Get home name from user
				fmt.Print("Name the center of your future empire (max 30 characters): ")
				homeName, err := reader.ReadCommandInput()
				if err != nil {
					fmt.Printf("Error reading input: %v\n", err)
					fmt.Print("Press any key to continue...")
					GetInput()
					return []string{"mainMenu"}, nil
				}

				// Validate home name
				homeName = strings.TrimSpace(homeName)
				if homeName == "" {
					fmt.Println("Home name cannot be empty!")
					fmt.Print("Press any key to continue...")
					GetInput()
					return []string{"mainMenu"}, nil
				}

				if len(homeName) > 30 {
					fmt.Println("Home name cannot exceed 30 characters!")
					fmt.Print("Press any key to continue...")
					GetInput()
					return []string{"mainMenu"}, nil
				}

				// Validate that homeName is a safe string (basic validation)
				if !isValidHomeName(homeName) {
					fmt.Println("Home name contains invalid characters! Use letters, numbers, spaces, and basic punctuation only.")
					fmt.Print("Press any key to continue...")
					GetInput()
					return []string{"mainMenu"}, nil
				}

				// Set the home location
				err = locations.SetHomeLocation(&loc, homeName)
				if err != nil {
					fmt.Printf("Error creating home location: %v\n", err)
					fmt.Print("Press any key to continue...")
					GetInput()
					return []string{"mainMenu"}, nil
				}

				// Success message
				fmt.Printf("New Home Created: '%s' at %s\n", homeName, loc.Name.String)
				fmt.Print("Press any key to continue...")
				GetInput()
				return []string{"mainMenu"}, nil
			},
		},
	}

	return &SimpleMenu{
		Title:   fmt.Sprintf("Create Home at %s", loc.Name.String),
		Options: options,
		BackFunction: func(routeStack []string) ([]string, error) {
			// Go back to main menu if user cancels
			return []string{"mainMenu"}, nil
		},
	}, nil
}

// isValidHomeName validates that the home name contains only safe characters
func isValidHomeName(name string) bool {
	// Allow letters, numbers, spaces, and basic punctuation
	for _, r := range name {
		if !((r >= 'a' && r <= 'z') ||
			(r >= 'A' && r <= 'Z') ||
			(r >= '0' && r <= '9') ||
			r == ' ' || r == '.' || r == ',' || r == '\'' || r == '-' || r == '_') {
			return false
		}
	}
	return true
}