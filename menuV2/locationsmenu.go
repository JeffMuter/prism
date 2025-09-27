package menuV2

import (
	"fmt"
	"sort"
	"strings"
	"prism/locations"
)

// LocationsDataSource implements DataSource for location data
type LocationsDataSource struct {
	userId      int
	allData     []interface{}
	filteredData []interface{}
}

// NewLocationsDataSource creates a data source for locations
func NewLocationsDataSource(userId int) (*LocationsDataSource, error) {
	return &LocationsDataSource{
		userId: userId,
	}, nil
}

// GetData implements DataSource interface for locations
func (lds *LocationsDataSource) GetData(filters map[string]interface{}, sortColumn string, sortDir SortDirection) ([]interface{}, error) {
	locations, err := locations.GetLocationsForUser(lds.userId)
	if err != nil {
		return nil, fmt.Errorf("error getting locations for user: %w", err)
	}
	
	// Convert []Location to []interface{}
	var data []interface{}
	for _, loc := range locations {
		data = append(data, loc)
	}
	lds.allData = data
	
	// Apply filters
	filteredData := lds.applyFilters(data, filters)
	
	// Apply sorting
	sortedData := lds.applySorting(filteredData, sortColumn, sortDir)
	
	lds.filteredData = sortedData
	return sortedData, nil
}

// GetTotal returns total number of locations
func (lds *LocationsDataSource) GetTotal() int {
	return len(lds.filteredData)
}

// applyFilters applies filtering logic to the data
func (lds *LocationsDataSource) applyFilters(data []interface{}, filters map[string]interface{}) []interface{} {
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
			case "Workers":
				// For numeric filters, we could implement range filtering
				// For now, just skip
				continue
			}
		}
		
		if include {
			filtered = append(filtered, item)
		}
	}
	
	return filtered
}

// applySorting applies sorting logic to the data
func (lds *LocationsDataSource) applySorting(data []interface{}, sortColumn string, sortDir SortDirection) []interface{} {
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

// handleLocationRowSelection handles when a user selects a location row
func handleLocationRowSelection(selectedItem interface{}, routeStack []string, params ...interface{}) ([]string, error) {
	loc, ok := selectedItem.(locations.Location)
	if !ok {
		return routeStack, fmt.Errorf("selected item is not a location")
	}
	
	// Create location detail menu and add to route stack
	detailMenu, err := CreateLocationDetailMenu(loc)
	if err != nil {
		return routeStack, fmt.Errorf("error creating location detail menu: %w", err)
	}
	
	// Add location detail route to stack
	newRouteStack := append(routeStack, fmt.Sprintf("location-%d", loc.Id))
	return detailMenu.Show(newRouteStack, params...)
}

// CreateLocationsGridMenu creates a grid menu for viewing locations
func CreateLocationsGridMenu(userId int) (*GridMenu, error) {
	// Create data source
	dataSource, err := NewLocationsDataSource(userId)
	if err != nil {
		return nil, fmt.Errorf("error creating locations data source: %w", err)
	}
	
	// Get location types for select column options
	locationTypes, err := getLocationTypes()
	if err != nil {
		return nil, fmt.Errorf("error getting location types: %w", err)
	}
	
	var typeOptions []string
	for _, lt := range locationTypes {
		typeOptions = append(typeOptions, lt.Name)
	}
	
	// Define columns
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
	gridMenu := NewGridMenu("LOCATIONS", columns, dataSource, 10)
	
	// Set the row selection callback
	gridMenu.OnRowSelect = handleLocationRowSelection
	
	return gridMenu, nil
}

// CreateLocationDetailMenu creates a detail view for a specific location
func CreateLocationDetailMenu(loc locations.Location) (*SimpleMenu, error) {
	// For now, create a simple static menu with basic location info
	// This can be expanded to a more detailed grid menu later
	
	options := []Option{
		{
			Name:        "View Resources",
			Description: "Show resources at this location",
			Action: func(params ...interface{}) ([]string, error) {
				// TODO: Implement resource view
				fmt.Printf("Resources for %s not implemented yet\n", loc.Name.String)
				fmt.Print("Press any key to continue...")
				GetInput()
				return []string{}, nil
			},
		},
		{
			Name:        "Manage Workers",
			Description: "Assign or remove workers",
			Action: func(params ...interface{}) ([]string, error) {
				// TODO: Implement worker management
				fmt.Printf("Worker management for %s not implemented yet\n", loc.Name.String)
				fmt.Print("Press any key to continue...")
				GetInput()
				return []string{}, nil
			},
		},
		{
			Name:        "View Tasks",
			Description: "Show available tasks",
			Action: func(params ...interface{}) ([]string, error) {
				// TODO: Implement task view
				fmt.Printf("Tasks for %s not implemented yet\n", loc.Name.String)
				fmt.Print("Press any key to continue...")
				GetInput()
				return []string{}, nil
			},
		},
	}
	
	return &SimpleMenu{
		Title:   fmt.Sprintf("%s - %s", loc.Name.String, loc.LocationType),
		Options: options,
	}, nil
}