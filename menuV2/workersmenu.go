package menuV2

import (
	"fmt"
	"sort"
	"strings"
	"prism/locations"
	"prism/workers"
	"prism/tasks"
	"prism/util"
	"prism/user"
)

// WorkersDataSource implements DataSource for worker data
type WorkersDataSource struct {
	userId       int
	locationId   *int // nil for all workers, specific location ID for location-filtered workers
	allData      []interface{}
	filteredData []interface{}
}

// NewWorkersDataSource creates a data source for workers
// locationId can be nil for all workers, or specific location ID for location-filtered workers
func NewWorkersDataSource(userId int, locationId *int) (*WorkersDataSource, error) {
	return &WorkersDataSource{
		userId:     userId,
		locationId: locationId,
	}, nil
}

// GetData implements DataSource interface for workers
func (wds *WorkersDataSource) GetData(filters map[string]interface{}, sortColumn string, sortDir SortDirection) ([]interface{}, error) {
	var workersList []workers.Worker
	var err error

	if wds.locationId != nil {
		// Get workers for specific location
		workersList, err = workers.GetWorkersRelatedToLocation(*wds.locationId)
		if err != nil {
			return nil, fmt.Errorf("error getting workers for location %d: %w", *wds.locationId, err)
		}
	} else {
		// Get all workers for user
		userObj := user.User{Id: wds.userId}
		workersList, err = workers.GetWorkersRelevantToUser(userObj)
		if err != nil {
			return nil, fmt.Errorf("error getting workers for user: %w", err)
		}
	}

	// Convert []Worker to []interface{}
	var data []interface{}
	for _, worker := range workersList {
		data = append(data, worker)
	}
	wds.allData = data

	// Apply filters
	filteredData := wds.applyFilters(data, filters)

	// Apply sorting
	sortedData := wds.applySorting(filteredData, sortColumn, sortDir)

	wds.filteredData = sortedData
	return sortedData, nil
}

// GetTotal returns total number of workers
func (wds *WorkersDataSource) GetTotal() int {
	return len(wds.filteredData)
}

// applyFilters applies filtering logic to worker data
func (wds *WorkersDataSource) applyFilters(data []interface{}, filters map[string]interface{}) []interface{} {
	if len(filters) == 0 {
		return data
	}

	var filtered []interface{}
	for _, item := range data {
		worker := item.(workers.Worker)
		include := true

		// Check each filter
		for column, filterValue := range filters {
			switch column {
			case "Name":
				// Fuzzy search on name
				searchTerm := strings.ToLower(filterValue.(string))
				workerName := strings.ToLower(worker.Name)
				if !strings.Contains(workerName, searchTerm) {
					include = false
					break
				}
			case "Location":
				// Exact match on location name
				if worker.LocationName != filterValue.(string) {
					include = false
					break
				}
			case "Status":
				// Working/Resting status
				filterStatus := filterValue.(string)
				workerStatus := "Resting"
				if worker.WorkStatus {
					workerStatus = "Working"
				}
				if workerStatus != filterStatus {
					include = false
					break
				}
			case "Task":
				// Exact match on work type
				if worker.WorkType != filterValue.(string) {
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

// applySorting applies sorting logic to worker data
func (wds *WorkersDataSource) applySorting(data []interface{}, sortColumn string, sortDir SortDirection) []interface{} {
	if sortDir == SortNone || sortColumn == "" {
		return data
	}

	// Create a copy to sort
	sorted := make([]interface{}, len(data))
	copy(sorted, data)

	// Sort based on column and direction
	sort.Slice(sorted, func(i, j int) bool {
		worker1 := sorted[i].(workers.Worker)
		worker2 := sorted[j].(workers.Worker)

		switch sortColumn {
		case "#":
			if sortDir == SortHighToLow {
				return worker1.Id > worker2.Id
			} else {
				return worker1.Id < worker2.Id
			}
		case "Name":
			if sortDir == SortHighToLow {
				return worker1.Name > worker2.Name
			} else {
				return worker1.Name < worker2.Name
			}
		case "Strength":
			if sortDir == SortHighToLow {
				return worker1.Strength > worker2.Strength
			} else {
				return worker1.Strength < worker2.Strength
			}
		}
		return false
	})

	return sorted
}

// handleWorkerRowSelection handles when a user selects a worker row
func handleWorkerRowSelection(selectedItem interface{}, routeStack []string, params ...interface{}) ([]string, error) {
	worker, ok := selectedItem.(workers.Worker)
	if !ok {
		return routeStack, fmt.Errorf("selected item is not a worker")
	}

	// Create worker detail menu and add to route stack
	detailMenu, err := CreateWorkerDetailMenu(worker)
	if err != nil {
		return routeStack, fmt.Errorf("error creating worker detail menu: %w", err)
	}

	// Add worker detail route to stack
	newRouteStack := append(routeStack, fmt.Sprintf("worker-%d", worker.Id))
	return detailMenu.Show(newRouteStack, params...)
}

// CreateWorkersGridMenu creates a grid menu for viewing workers
// locationId can be nil for all workers, or specific location ID for location-filtered workers
func CreateWorkersGridMenu(userId int, locationId *int) (*GridMenu, error) {
	// Create data source
	dataSource, err := NewWorkersDataSource(userId, locationId)
	if err != nil {
		return nil, fmt.Errorf("error creating workers data source: %w", err)
	}

	// Get user locations for location filter options
	userLocations, err := locations.GetLocationsForUser(userId)
	if err != nil {
		return nil, fmt.Errorf("error getting user locations: %w", err)
	}

	var locationOptions []string
	for _, loc := range userLocations {
		locationOptions = append(locationOptions, loc.Name.String)
	}

	// Get task types for task filter (use all task types for now)
	taskTypes, err := tasks.GetListOfTaskTypes()
	if err != nil {
		return nil, fmt.Errorf("error getting task types: %w", err)
	}

	// Define columns
	columns := []Column{
		{
			Name:  "#",
			Type:  NumericColumn,
			Width: 5,
			Accessor: func(data interface{}) string {
				worker := data.(workers.Worker)
				return fmt.Sprintf("%d", worker.Id)
			},
		},
		{
			Name:  "Name",
			Type:  TextColumn,
			Width: 20,
			Accessor: func(data interface{}) string {
				worker := data.(workers.Worker)
				return worker.Name
			},
		},
		{
			Name:  "Task",
			Type:  SelectColumn,
			Width: 15,
			Options: taskTypes,
			Accessor: func(data interface{}) string {
				worker := data.(workers.Worker)
				if worker.WorkType == "" {
					return "resting"
				}
				return worker.WorkType
			},
		},
		{
			Name:    "Location",
			Type:    SelectColumn,
			Width:   20,
			Options: locationOptions,
			Accessor: func(data interface{}) string {
				worker := data.(workers.Worker)
				return worker.LocationName
			},
		},
		{
			Name:    "Status",
			Type:    SelectColumn,
			Width:   10,
			Options: []string{"Working", "Resting"},
			Accessor: func(data interface{}) string {
				worker := data.(workers.Worker)
				if worker.WorkStatus {
					return "Working"
				}
				return "Resting"
			},
		},
		{
			Name:  "Strength",
			Type:  NumericColumn,
			Width: 8,
			Accessor: func(data interface{}) string {
				worker := data.(workers.Worker)
				return fmt.Sprintf("%d", worker.Strength)
			},
		},
	}

	// Determine title based on context
	title := "ALL WORKERS"
	if locationId != nil {
		// Get location name for title
		loc, err := locations.GetLocationFromLocationId(*locationId)
		if err == nil {
			title = fmt.Sprintf("WORKERS AT %s", strings.ToUpper(loc.Name.String))
		}
	}

	// Create grid menu with 15 items per page
	gridMenu := NewGridMenu(title, columns, dataSource, 15)

	// Set the row selection callback
	gridMenu.OnRowSelect = handleWorkerRowSelection

	return gridMenu, nil
}

// CreateWorkerDetailMenu creates a detail view for a specific worker with actions
func CreateWorkerDetailMenu(worker workers.Worker) (*SimpleMenu, error) {
	options := []Option{
		{
			Name:        "Move Worker",
			Description: "Relocate this worker to a different location",
			Action: func(params ...interface{}) ([]string, error) {
				return MoveWorkerAction(worker, params...)
			},
		},
		{
			Name:        "Assign Task",
			Description: "Give this worker a new task assignment",
			Action: func(params ...interface{}) ([]string, error) {
				return AssignTaskAction(worker, params...)
			},
		},
		{
			Name:        "Toggle Work Status",
			Description: "Switch between working and resting",
			Action: func(params ...interface{}) ([]string, error) {
				return ToggleWorkStatusAction(worker, params...)
			},
		},
		{
			Name:        "View Worker Details",
			Description: "Show detailed worker statistics",
			Action: func(params ...interface{}) ([]string, error) {
				return ViewWorkerDetailsAction(worker, params...)
			},
		},
	}

	// Create detailed title with worker info
	statusText := "Resting"
	if worker.WorkStatus {
		statusText = "Working"
	}

	title := fmt.Sprintf("%s - %s (%s)", worker.Name, worker.LocationName, statusText)
	if worker.WorkType != "" {
		title = fmt.Sprintf("%s - %s - %s (%s)", worker.Name, worker.WorkType, worker.LocationName, statusText)
	}

	return &SimpleMenu{
		Title:   title,
		Options: options,
		BackFunction: func(routeStack []string) ([]string, error) {
			// Go back to workers grid
			if len(routeStack) > 0 {
				return routeStack[:len(routeStack)-1], nil
			}
			return []string{"mainMenu"}, nil
		},
	}, nil
}

// Worker action implementations

// MoveWorkerAction handles moving a worker to a different location
func MoveWorkerAction(worker workers.Worker, params ...interface{}) ([]string, error) {
	if len(params) < 2 {
		return []string{}, fmt.Errorf("move worker requires user and reader parameters")
	}

	thisUser, ok := params[0].(user.User)
	if !ok {
		return []string{}, fmt.Errorf("first parameter must be user.User")
	}

	reader, ok := params[1].(util.InputReader)
	if !ok {
		return []string{}, fmt.Errorf("second parameter must be util.InputReader")
	}

	// Get user locations
	userLocations, err := locations.GetLocationsForUser(thisUser.Id)
	if err != nil {
		fmt.Printf("Error getting locations: %v\n", err)
		fmt.Print("Press any key to continue...")
		GetInput()
		return []string{}, nil
	}

	// Create location selection menu
	var options []Option
	for _, loc := range userLocations {
		if loc.Id == worker.LocationId {
			continue // Skip current location
		}

		location := loc // Capture for closure
		options = append(options, Option{
			Name:        location.Name.String,
			Description: fmt.Sprintf("Move %s to %s", worker.Name, location.Name.String),
			Action: func(moveParams ...interface{}) ([]string, error) {
				// Move the worker
				err := workers.MoveWorkerToLocation(worker, location)
				if err != nil {
					fmt.Printf("Error moving worker: %v\n", err)
					fmt.Print("Press any key to continue...")
					GetInput()
					return []string{}, nil
				}

				// Set worker to resting
				err = tasks.SetWorkerTaskToNewTask(worker, "resting")
				if err != nil {
					fmt.Printf("Warning: Worker moved but failed to set to resting: %v\n", err)
				}

				fmt.Printf("Successfully moved %s to %s\n", worker.Name, location.Name.String)
				fmt.Print("Press any key to continue...")
				GetInput()
				return []string{}, nil
			},
		})
	}

	if len(options) == 0 {
		fmt.Printf("%s is already at the only available location.\n", worker.Name)
		fmt.Print("Press any key to continue...")
		GetInput()
		return []string{}, nil
	}

	locationMenu := &SimpleMenu{
		Title:   fmt.Sprintf("Move %s to Location", worker.Name),
		Options: options,
		BackFunction: func(routeStack []string) ([]string, error) {
			return []string{}, nil
		},
	}

	_, err = locationMenu.Show([]string{}, reader)
	return []string{}, err
}

// AssignTaskAction handles assigning a new task to a worker
func AssignTaskAction(worker workers.Worker, params ...interface{}) ([]string, error) {
	if len(params) < 1 {
		return []string{}, fmt.Errorf("assign task requires reader parameter")
	}

	reader, ok := params[1].(util.InputReader)
	if !ok {
		return []string{}, fmt.Errorf("second parameter must be util.InputReader")
	}

	// Get available tasks for this worker's location
	availableTasks, err := tasks.GetMapTaskTypeIdTaskNameFromLocationId(worker.LocationId)
	if err != nil {
		fmt.Printf("Error getting available tasks: %v\n", err)
		fmt.Print("Press any key to continue...")
		GetInput()
		return []string{}, nil
	}

	// Create task selection menu
	var options []Option
	for _, taskName := range availableTasks {
		taskType := taskName // Capture for closure
		options = append(options, Option{
			Name:        taskType,
			Description: fmt.Sprintf("Assign %s to %s", worker.Name, taskType),
			Action: func(taskParams ...interface{}) ([]string, error) {
				// Assign the task
				err := tasks.SetWorkerTaskToNewTask(worker, taskType)
				if err != nil {
					fmt.Printf("Error assigning task: %v\n", err)
					fmt.Print("Press any key to continue...")
					GetInput()
					return []string{}, nil
				}

				fmt.Printf("Successfully assigned %s to %s\n", worker.Name, taskType)
				fmt.Print("Press any key to continue...")
				GetInput()
				return []string{}, nil
			},
		})
	}

	if len(options) == 0 {
		fmt.Printf("No tasks available at %s\n", worker.LocationName)
		fmt.Print("Press any key to continue...")
		GetInput()
		return []string{}, nil
	}

	taskMenu := &SimpleMenu{
		Title:   fmt.Sprintf("Assign Task to %s", worker.Name),
		Options: options,
		BackFunction: func(routeStack []string) ([]string, error) {
			return []string{}, nil
		},
	}

	_, err = taskMenu.Show([]string{}, reader)
	return []string{}, err
}

// ToggleWorkStatusAction handles toggling worker work status
func ToggleWorkStatusAction(worker workers.Worker, params ...interface{}) ([]string, error) {
	err := workers.ToggleWorkingForWorker(worker)
	if err != nil {
		fmt.Printf("Error toggling work status: %v\n", err)
		fmt.Print("Press any key to continue...")
		GetInput()
		return []string{}, nil
	}

	newStatus := "resting"
	if !worker.WorkStatus { // Status will be toggled
		newStatus = "working"
	}

	fmt.Printf("Successfully set %s to %s\n", worker.Name, newStatus)
	fmt.Print("Press any key to continue...")
	GetInput()
	return []string{}, nil
}

// ViewWorkerDetailsAction shows detailed worker statistics
func ViewWorkerDetailsAction(worker workers.Worker, params ...interface{}) ([]string, error) {
	fmt.Printf("\n=== %s Details ===\n", worker.Name)
	fmt.Printf("ID: %d\n", worker.Id)
	fmt.Printf("Location: %s\n", worker.LocationName)
	fmt.Printf("Current Task: %s\n", worker.WorkType)

	status := "Resting"
	if worker.WorkStatus {
		status = "Working"
	}
	fmt.Printf("Work Status: %s\n", status)

	injured := "No"
	if worker.InjuredStatus {
		injured = "Yes"
	}
	fmt.Printf("Injured: %s\n", injured)

	fmt.Printf("Religion: %s\n", worker.Religion)
	fmt.Printf("\n--- Stats ---\n")
	fmt.Printf("Strength: %d\n", worker.Strength)
	fmt.Printf("Intelligence: %d\n", worker.Intelligence)
	fmt.Printf("Faith: %d\n", worker.Faith)

	fmt.Print("\nPress any key to continue...")
	GetInput()
	return []string{}, nil
}