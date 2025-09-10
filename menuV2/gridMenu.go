package menuV2

import (
	"fmt"
	"sort"
	"strings"
	"prism/locations"
	"prism/util"
)

// ColumnType defines the behavior of a column for filtering and sorting
type ColumnType int

const (
	TextColumn ColumnType = iota // Supports fuzzy search filtering
	SelectColumn                 // Dropdown selection from predefined options
	NumericColumn               // Sort toggle: none → high → low → none
)

// SortDirection represents the current sort state for numeric columns
type SortDirection int

const (
	SortNone SortDirection = iota
	SortHighToLow
	SortLowToHigh
)

// Column defines a column in the grid menu
type Column struct {
	Name     string                           // Display name
	Type     ColumnType                       // Column behavior type
	Width    int                             // Column width in characters
	Accessor func(interface{}) string        // Function to extract data from row
	Options  []string                        // Available options for SelectColumn
}

// DataSource interface for providing data to the grid menu
type DataSource interface {
	GetData(filters map[string]interface{}, sortColumn string, sortDir SortDirection) ([]interface{}, error)
	GetTotal() int
}

// GridMenu implements a table-style menu with filtering and sorting
type GridMenu struct {
	Title      string
	Columns    []Column
	DataSource DataSource
	
	// Navigation state
	currentRow    int
	currentColumn int
	isInHeader    bool // true if navigating column headers, false if in data
	
	// Filtering and sorting state
	filters       map[string]interface{}
	sortColumn    string
	sortDirection SortDirection
	
	// Pagination
	pageSize    int
	currentPage int
	
	// Cached data
	cachedData    []interface{}
	cachedTotal   int
	needsRefresh  bool
}

// NewGridMenu creates a new grid menu
func NewGridMenu(title string, columns []Column, dataSource DataSource, pageSize int) *GridMenu {
	return &GridMenu{
		Title:         title,
		Columns:       columns,
		DataSource:    dataSource,
		pageSize:      pageSize,
		currentRow:    0,
		currentColumn: 0,
		isInHeader:    true,
		filters:       make(map[string]interface{}),
		sortDirection: SortNone,
		needsRefresh:  true,
	}
}

// Show implements the Menu interface
func (gm *GridMenu) Show(routeStack []string, params ...interface{}) ([]string, error) {
	if len(params) < 2 {
		return routeStack, fmt.Errorf("GridMenu requires user and reader parameters")
	}
	
	reader, ok := params[1].(util.InputReader)
	if !ok {
		return routeStack, fmt.Errorf("second parameter must be util.InputReader")
	}
	
	for {
		// Refresh data if needed
		if gm.needsRefresh {
			err := gm.refreshData()
			if err != nil {
				return routeStack, fmt.Errorf("error refreshing data: %w", err)
			}
		}
		
		// Render the grid
		err := gm.render()
		if err != nil {
			return routeStack, fmt.Errorf("error rendering grid: %w", err)
		}
		
		// Handle input
		action, err := gm.handleInput(reader)
		if err != nil {
			return routeStack, fmt.Errorf("error handling input: %w", err)
		}
		
		switch action {
		case "back":
			// Remove last route from stack
			if len(routeStack) > 0 {
				return routeStack[:len(routeStack)-1], nil
			}
			return []string{}, nil
		case "select":
			// Handle selection action
			if gm.isInHeader {
				err := gm.handleColumnAction(reader)
				if err != nil {
					return routeStack, fmt.Errorf("error handling column action: %w", err)
				}
			} else {
				// Handle row selection - for now just continue
				continue
			}
		case "filter":
			// Apply current filters and refresh
			gm.needsRefresh = true
			continue
		}
	}
}

// refreshData fetches fresh data from the data source
func (gm *GridMenu) refreshData() error {
	data, err := gm.DataSource.GetData(gm.filters, gm.sortColumn, gm.sortDirection)
	if err != nil {
		return err
	}
	
	gm.cachedData = data
	gm.cachedTotal = gm.DataSource.GetTotal()
	gm.needsRefresh = false
	
	// Reset navigation if current row is out of bounds
	maxRow := len(gm.cachedData) - 1
	if gm.currentRow > maxRow {
		gm.currentRow = 0
		gm.isInHeader = true
	}
	
	return nil
}

// render displays the grid menu
func (gm *GridMenu) render() error {
	fmt.Print("\033[2J\033[H") // Clear screen and move cursor to top
	
	// Calculate total width needed
	totalWidth := gm.calculateTotalWidth()
	border := GetUnicodeBorder()
	
	// Render title
	fmt.Printf("%s%s%s\n", border.TopLeft, strings.Repeat(border.Horizontal, totalWidth-2), border.TopRight)
	fmt.Printf("%s %s%s %s\n", border.Vertical, gm.Title, strings.Repeat(" ", totalWidth-len(gm.Title)-4), border.Vertical)
	
	// Render column headers with separator
	fmt.Printf("%s%s%s\n", border.Vertical, strings.Repeat(border.Horizontal, totalWidth-2), border.Vertical)
	gm.renderHeaders(border)
	fmt.Printf("%s%s%s\n", border.Vertical, strings.Repeat(border.Horizontal, totalWidth-2), border.Vertical)
	
	// Render data rows
	gm.renderDataRows(border, totalWidth)
	
	// Render bottom border
	fmt.Printf("%s%s%s\n", border.BottomLeft, strings.Repeat(border.Horizontal, totalWidth-2), border.BottomRight)
	
	// Render status/help
	gm.renderStatus()
	
	return nil
}

// calculateTotalWidth calculates the total width needed for the grid
func (gm *GridMenu) calculateTotalWidth() int {
	width := 2 // Left and right borders
	for i, col := range gm.Columns {
		width += col.Width
		if i < len(gm.Columns)-1 {
			width += 1 // Column separator
		}
	}
	return width
}

// renderHeaders renders the column headers
func (gm *GridMenu) renderHeaders(border Border) {
	fmt.Print(border.Vertical)
	for i, col := range gm.Columns {
		// Highlight current column if in header mode
		highlight := gm.isInHeader && gm.currentColumn == i
		
		headerText := col.Name
		if col.Name == gm.sortColumn {
			switch gm.sortDirection {
			case SortHighToLow:
				headerText += " ↓"
			case SortLowToHigh:
				headerText += " ↑"
			}
		}
		
		// Add highlighting
		if highlight {
			headerText = fmt.Sprintf("[%s]", headerText)
		}
		
		// Pad to column width
		padded := fmt.Sprintf("%-*s", col.Width, headerText)
		if len(padded) > col.Width {
			padded = padded[:col.Width-1] + "…"
		}
		
		fmt.Print(padded)
		
		// Add column separator
		if i < len(gm.Columns)-1 {
			fmt.Print(border.Vertical)
		}
	}
	fmt.Print(border.Vertical + "\n")
}

// renderDataRows renders the data rows with pagination
func (gm *GridMenu) renderDataRows(border Border, totalWidth int) {
	start := gm.currentPage * gm.pageSize
	end := start + gm.pageSize
	if end > len(gm.cachedData) {
		end = len(gm.cachedData)
	}
	
	for i := start; i < end; i++ {
		row := gm.cachedData[i]
		highlight := !gm.isInHeader && gm.currentRow == i
		
		fmt.Print(border.Vertical)
		for j, col := range gm.Columns {
			cellData := col.Accessor(row)
			
			// Add highlighting for current cell
			if highlight && gm.currentColumn == j {
				cellData = fmt.Sprintf("[%s]", cellData)
			}
			
			// Pad to column width
			padded := fmt.Sprintf("%-*s", col.Width, cellData)
			if len(padded) > col.Width {
				padded = padded[:col.Width-1] + "…"
			}
			
			fmt.Print(padded)
			
			// Add column separator
			if j < len(gm.Columns)-1 {
				fmt.Print(border.Vertical)
			}
		}
		fmt.Print(border.Vertical + "\n")
	}
	
	// Fill remaining rows if less than page size
	for i := end - start; i < gm.pageSize && len(gm.cachedData) > 0; i++ {
		fmt.Printf("%s%s%s\n", border.Vertical, strings.Repeat(" ", totalWidth-2), border.Vertical)
	}
}

// renderStatus renders status and help information
func (gm *GridMenu) renderStatus() {
	totalPages := (gm.cachedTotal + gm.pageSize - 1) / gm.pageSize
	if totalPages == 0 {
		totalPages = 1
	}
	
	fmt.Printf("\nPage %d of %d | Total: %d items\n", gm.currentPage+1, totalPages, gm.cachedTotal)
	
	if gm.isInHeader {
		fmt.Println("Arrow keys: navigate columns | Enter: filter/sort | Tab: switch to data | Esc: back")
	} else {
		fmt.Println("Arrow keys: navigate | Enter: select | Tab: switch to headers | Esc: back")
	}
	
	// Show active filters
	if len(gm.filters) > 0 {
		fmt.Print("Active filters: ")
		var filterStrs []string
		for col, val := range gm.filters {
			filterStrs = append(filterStrs, fmt.Sprintf("%s=%v", col, val))
		}
		fmt.Println(strings.Join(filterStrs, ", "))
	}
}

// handleInput processes user input and returns action
func (gm *GridMenu) handleInput(reader util.InputReader) (string, error) {
	input, err := GetInput()
	if err != nil {
		return "", err
	}
	
	switch input.Type {
	case ArrowUp:
		gm.navigateUp()
	case ArrowDown:
		gm.navigateDown()
	case EnterKey:
		return "select", nil
	case BackCommand:
		return "back", nil
	case MapCommand:
		return "back", nil
	case InvalidInput:
		// Handle additional keys for grid navigation
		switch strings.ToLower(input.Value) {
		case "a":
			gm.navigateLeft()
		case "d":
			gm.navigateRight()
		case "q":
			return "back", nil
		}
	}
	
	// Handle tab key (ASCII 9)
	if len(input.Value) == 1 && input.Value[0] == 9 {
		gm.isInHeader = !gm.isInHeader
		if !gm.isInHeader && len(gm.cachedData) > 0 {
			gm.currentRow = gm.currentPage * gm.pageSize
		}
	}
	
	return "", nil
}

// Navigation methods
func (gm *GridMenu) navigateUp() {
	if gm.isInHeader {
		return // Can't go up from headers
	}
	
	if gm.currentRow > gm.currentPage*gm.pageSize {
		gm.currentRow--
	} else if gm.currentPage > 0 {
		gm.currentPage--
		gm.currentRow = (gm.currentPage+1)*gm.pageSize - 1
		gm.needsRefresh = true
	}
}

func (gm *GridMenu) navigateDown() {
	if gm.isInHeader {
		if len(gm.cachedData) > 0 {
			gm.isInHeader = false
			gm.currentRow = gm.currentPage * gm.pageSize
		}
		return
	}
	
	maxRow := len(gm.cachedData) - 1
	nextPageStart := (gm.currentPage + 1) * gm.pageSize
	
	if gm.currentRow < maxRow && gm.currentRow < nextPageStart-1 {
		gm.currentRow++
	} else if nextPageStart <= maxRow {
		gm.currentPage++
		gm.currentRow = nextPageStart
		gm.needsRefresh = true
	}
}

func (gm *GridMenu) navigateLeft() {
	if gm.currentColumn > 0 {
		gm.currentColumn--
	}
}

func (gm *GridMenu) navigateRight() {
	if gm.currentColumn < len(gm.Columns)-1 {
		gm.currentColumn++
	}
}

// handleColumnAction handles actions on column headers (filtering/sorting)
func (gm *GridMenu) handleColumnAction(reader util.InputReader) error {
	col := gm.Columns[gm.currentColumn]
	
	switch col.Type {
	case NumericColumn:
		return gm.handleNumericColumnSort(col.Name)
	case SelectColumn:
		return gm.handleSelectColumnFilter(col, reader)
	case TextColumn:
		return gm.handleTextColumnFilter(col.Name, reader)
	}
	
	return nil
}

// handleNumericColumnSort toggles sort direction for numeric columns
func (gm *GridMenu) handleNumericColumnSort(columnName string) error {
	if gm.sortColumn == columnName {
		// Cycle through sort states
		switch gm.sortDirection {
		case SortNone:
			gm.sortDirection = SortHighToLow
		case SortHighToLow:
			gm.sortDirection = SortLowToHigh
		case SortLowToHigh:
			gm.sortDirection = SortNone
			gm.sortColumn = ""
		}
	} else {
		// New column, start with high to low
		gm.sortColumn = columnName
		gm.sortDirection = SortHighToLow
	}
	
	gm.needsRefresh = true
	return nil
}

// handleSelectColumnFilter shows options for select columns
func (gm *GridMenu) handleSelectColumnFilter(col Column, reader util.InputReader) error {
	fmt.Printf("\nFilter by %s:\n", col.Name)
	for i, option := range col.Options {
		fmt.Printf("%d. %s\n", i+1, option)
	}
	fmt.Printf("%d. Clear filter\n", len(col.Options)+1)
	fmt.Print("Select option: ")
	
	input, err := reader.ReadCommandInput()
	if err != nil {
		return err
	}
	
	// Parse selection (simplified)
	if input == fmt.Sprintf("%d", len(col.Options)+1) {
		delete(gm.filters, col.Name)
	} else {
		// For now, just store the input as filter value
		gm.filters[col.Name] = input
	}
	
	gm.needsRefresh = true
	return nil
}

// handleTextColumnFilter handles fuzzy search for text columns
func (gm *GridMenu) handleTextColumnFilter(columnName string, reader util.InputReader) error {
	fmt.Printf("\nSearch %s (fuzzy): ", columnName)
	input, err := reader.ReadCommandInput()
	if err != nil {
		return err
	}
	
	if strings.TrimSpace(input) == "" {
		delete(gm.filters, columnName)
	} else {
		gm.filters[columnName] = strings.TrimSpace(input)
	}
	
	gm.needsRefresh = true
	return nil
}

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
	// Import locations package functions (assuming they're available)
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
	
	return gridMenu, nil
}