package menuV2

import (
	"fmt"
	"strconv"
	"strings"
)

// Option represents a menu choice with its action
type Option struct {
	Name        string
	Description string
	Action      func(params ...interface{}) ([]string, error)
}

// StaticMenu represents a simple menu with fixed options
type StaticMenu struct {
	Title        string
	Options      []Option
	BackFunction func(routeStack []string) ([]string, error)
}

// ANSI color codes
const (
	Reset   = "\033[0m"
	Red     = "\033[31m"
	Green   = "\033[32m"
	Yellow  = "\033[33m"
	Blue    = "\033[34m"
	Magenta = "\033[35m"
	Cyan    = "\033[36m"
	White   = "\033[37m"
	BgBlue  = "\033[44m"
	BgWhite = "\033[47m"
	BgBlack = "\033[40m"
)

// Box drawing characters
const (
	TopLeft     = "┌"
	TopRight    = "┐"
	BottomLeft  = "└"
	BottomRight = "┘"
	Horizontal  = "─"
	Vertical    = "│"
)

// renderBorder draws the menu with Unicode box drawing characters
func (m *StaticMenu) renderBorder(selectedIndex int) {
	// Calculate width based on title and options
	width := len(m.Title) + 4
	for _, option := range m.Options {
		optionWidth := len(fmt.Sprintf("  %d. %s", len(m.Options), option.Name)) + 4
		if optionWidth > width {
			width = optionWidth
		}
	}

	// Top border with title
	fmt.Print(TopLeft)
	titlePadding := (width - len(m.Title) - 2) / 2
	fmt.Print(strings.Repeat(Horizontal, titlePadding))
	fmt.Print(" " + m.Title + " ")
	fmt.Print(strings.Repeat(Horizontal, width-titlePadding-len(m.Title)-3))
	fmt.Println(TopRight)

	// Menu options
	for i, option := range m.Options {
		fmt.Print(Vertical)
		optionText := fmt.Sprintf("  %d. %s", i+1, option.Name)

		if i == selectedIndex {
			// Highlight selected option
			fmt.Print(BgBlue + White + optionText)
			fmt.Print(strings.Repeat(" ", width-len(optionText)-2))
			fmt.Print(Reset)
		} else {
			fmt.Print(optionText)
			fmt.Print(strings.Repeat(" ", width-len(optionText)-2))
		}
		fmt.Println(Vertical)
	}

	// Bottom border
	fmt.Print(BottomLeft)
	fmt.Print(strings.Repeat(Horizontal, width-2))
	fmt.Println(BottomRight)
}

// Show displays the menu and handles user input
func (m *StaticMenu) Show(routeStack []string, params ...interface{}) ([]string, error) {
	selectedIndex := 0

	for {
		// Clear screen and show menu
		fmt.Print("\033[2J\033[H") // Clear screen and move cursor to top
		m.renderBorder(selectedIndex)

		fmt.Println("\nNavigation: ↑/↓ to select, Enter to choose, numbers 1-9, 'b' for back, 'm' for map")
		fmt.Print("Choice: ")

		input, err := GetInput()
		if err != nil {
			fmt.Printf("Error reading input: %v\nPress any key to continue...", err)
			GetInput()
			continue
		}

		switch input.Type {
		case ArrowUp:
			if selectedIndex > 0 {
				selectedIndex--
			}
		case ArrowDown:
			if selectedIndex < len(m.Options)-1 {
				selectedIndex++
			}
		case EnterKey:
			if selectedIndex >= 0 && selectedIndex < len(m.Options) {
				newRouteStack, err := m.Options[selectedIndex].Action(params...)
				if err != nil {
					fmt.Printf("\nError: %v\nPress any key to continue...", err)
					GetInput()
					// Exit to map after error instead of continuing menu loop
					return []string{}, nil
				}
				return newRouteStack, nil
			}
		case NumericInput:
			if num, err := strconv.Atoi(input.Value); err == nil {
				if num >= 1 && num <= len(m.Options) {
					selectedIndex = num - 1
					newRouteStack, err := m.Options[selectedIndex].Action(params...)
					if err != nil {
						fmt.Printf("\nError: %v\nPress any key to continue...", err)
						GetInput()
						// Exit to map after error instead of continuing menu loop
						return []string{}, nil
					}
					return newRouteStack, nil
				} else {
					fmt.Printf("\nInvalid selection. Please choose 1-%d.\nPress any key to continue...", len(m.Options))
					GetInput()
					continue
				}
			}
		case BackCommand:
			if m.BackFunction != nil {
				return m.BackFunction(routeStack)
			}
			// Default back behavior - remove last route
			if len(routeStack) > 0 {
				return routeStack[:len(routeStack)-1], nil
			}
			return routeStack, nil
		case MapCommand:
			return []string{}, nil
		case InvalidInput:
			fmt.Printf("\nInvalid input '%s'. Use ↑/↓, Enter, numbers 1-%d, 'b' for back, or 'm' for map.\nPress any key to continue...", input.Value, len(m.Options))
			GetInput()
			continue
		}
	}
}