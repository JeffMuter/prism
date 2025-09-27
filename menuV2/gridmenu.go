package menuV2

import (
	"fmt"
	"regexp"
	"strings"
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
	
	// Callback for row selection
	OnRowSelect func(selectedItem interface{}, routeStack []string, params ...interface{}) ([]string, error)
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
		isInHeader:    false,
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
				// Handle row selection - delegate to callback if provided
				if gm.currentRow < len(gm.cachedData) && gm.OnRowSelect != nil {
					selectedItem := gm.cachedData[gm.currentRow]
					return gm.OnRowSelect(selectedItem, routeStack, params...)
				}
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
	gm.renderTableHeader(border)
	fmt.Printf("%s%s%s\n", border.Vertical, strings.Repeat(border.Horizontal, totalWidth-2), border.Vertical)
	
	// Render data rows
	start := gm.currentPage * gm.pageSize
	end := start + gm.pageSize
	if end > len(gm.cachedData) {
		end = len(gm.cachedData)
	}
	
	for i := start; i < end; i++ {
		rowData := gm.cachedData[i]
		isSelected := !gm.isInHeader && gm.currentRow == i
		gm.renderTableRow(rowData, i, isSelected, border)
	}
	
	// Fill remaining rows if less than page size
	for i := end - start; i < gm.pageSize && len(gm.cachedData) > 0; i++ {
		fmt.Printf("%s%s%s\n", border.Vertical, strings.Repeat(" ", totalWidth-2), border.Vertical)
	}
	
	// Render bottom border
	fmt.Printf("%s%s%s\n", border.BottomLeft, strings.Repeat(border.Horizontal, totalWidth-2), border.BottomRight)
	
	// Render status/help
	gm.renderStatus()
	
	return nil
}

// Helper to get visual length (strips ANSI codes)
func visualLength(s string) int {
	// Remove ANSI escape sequences for accurate length calculation
	ansiRegex := regexp.MustCompile(`\x1b\[[0-9;]*m`)
	return len(ansiRegex.ReplaceAllString(s, ""))
}

// Format a cell with proper padding and optional highlighting
func (gm *GridMenu) formatCell(text string, width int, isHighlighted bool) string {
	// Apply highlighting first
	if isHighlighted {
		text = BgBlue + White + text + Reset
	}
	
	// Calculate padding based on visual length
	visualLen := visualLength(text)
	if visualLen > width {
		// Truncate cleanly without breaking ANSI codes
		plainText := strings.ReplaceAll(strings.ReplaceAll(text, BgBlue+White, ""), Reset, "")
		truncated := plainText[:width-1] + "…"
		if isHighlighted {
			truncated = BgBlue + White + truncated + Reset
		}
		return truncated
	}
	
	// Add padding
	padding := width - visualLen
	return text + strings.Repeat(" ", padding)
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

// Render table header with clean, readable logic
func (gm *GridMenu) renderTableHeader(border Border) {
	fmt.Print(border.Vertical)
	for i, col := range gm.Columns {
		headerText := col.Name
		if col.Name == gm.sortColumn {
			if gm.sortDirection == SortHighToLow {
				headerText += " ↓" 
			} else if gm.sortDirection == SortLowToHigh {
				headerText += " ↑"
			}
		}
		
		isHighlighted := gm.isInHeader && gm.currentColumn == i
		cellContent := gm.formatCell(headerText, col.Width, isHighlighted)
		fmt.Print(cellContent)
		
		if i < len(gm.Columns)-1 {
			fmt.Print(border.Vertical)
		}
	}
	fmt.Print(border.Vertical + "\n")
}

// Render single data row
func (gm *GridMenu) renderTableRow(rowData interface{}, rowIndex int, isSelected bool, border Border) {
	fmt.Print(border.Vertical)
	for i, col := range gm.Columns {
		cellData := col.Accessor(rowData)
		// Highlight entire row when selected (not just current column)
		isHighlighted := isSelected
		cellContent := gm.formatCell(cellData, col.Width, isHighlighted)
		fmt.Print(cellContent)
		
		if i < len(gm.Columns)-1 {
			fmt.Print(border.Vertical)
		}
	}
	fmt.Print(border.Vertical + "\n")
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
	
	fmt.Printf("DEBUG: GridMenu received input type: %v, value: '%s'\n", input.Type, input.Value)
	
	switch input.Type {
	case ArrowUp:
		fmt.Printf("DEBUG: GridMenu -> navigateUp()\n")
		gm.navigateUp()
	case ArrowDown:
		fmt.Printf("DEBUG: GridMenu -> navigateDown()\n")
		gm.navigateDown()
	case ArrowLeft:
		fmt.Printf("DEBUG: GridMenu -> navigateLeft()\n")
		gm.navigateLeft()
	case ArrowRight:
		fmt.Printf("DEBUG: GridMenu -> navigateRight()\n")
		gm.navigateRight()
	case EnterKey:
		fmt.Printf("DEBUG: GridMenu -> returning 'select'\n")
		return "select", nil
	case BackCommand:
		fmt.Printf("DEBUG: GridMenu -> returning 'back'\n")
		return "back", nil
	case MapCommand:
		fmt.Printf("DEBUG: GridMenu -> returning 'back' (map)\n")
		return "back", nil
	case InvalidInput:
		fmt.Printf("DEBUG: GridMenu -> handling InvalidInput: '%s'\n", input.Value)
		// Handle additional keys for grid navigation
		switch strings.ToLower(input.Value) {
		case "a":
			fmt.Printf("DEBUG: GridMenu -> navigateLeft() via 'a'\n")
			gm.navigateLeft()
		case "d":
			fmt.Printf("DEBUG: GridMenu -> navigateRight() via 'd'\n")
			gm.navigateRight()
		case "q":
			fmt.Printf("DEBUG: GridMenu -> returning 'back' via 'q'\n")
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
	// Create options for SimpleMenu
	var options []Option
	for _, option := range col.Options {
		optValue := option // Capture for closure
		options = append(options, Option{
			Name:        optValue,
			Description: fmt.Sprintf("Filter by %s", optValue),
			Action: func(params ...interface{}) ([]string, error) {
				gm.filters[col.Name] = optValue
				gm.needsRefresh = true
				return []string{}, nil
			},
		})
	}

	// Add clear filter option
	options = append(options, Option{
		Name:        "Clear filter",
		Description: "Remove current filter",
		Action: func(params ...interface{}) ([]string, error) {
			delete(gm.filters, col.Name)
			gm.needsRefresh = true
			return []string{}, nil
		},
	})

	menu := &SimpleMenu{
		Title:   fmt.Sprintf("Filter by %s", col.Name),
		Options: options,
		BackFunction: func(routeStack []string) ([]string, error) {
			// Return to grid menu
			return []string{}, nil
		},
	}

	// Show the menu with the same parameters the grid menu received
	_, err := menu.Show([]string{}, reader)
	return err
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