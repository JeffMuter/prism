package menuV2

import (
	"fmt"
	"strings"

	tea "github.com/charmbracelet/bubbletea"
	"github.com/charmbracelet/lipgloss"
)

// Option represents a menu choice with its action
type Option struct {
	Name        string
	Description string
	Action      func(params ...interface{}) ([]string, error)
}

// ANSI color codes (used by gridmenu for manual rendering)
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

var (
	// Color scheme
	primaryColor    = lipgloss.Color("205")
	subtleColor     = lipgloss.Color("241")
	highlightColor  = lipgloss.Color("86")
	borderColor     = lipgloss.Color("170")
	coralOrange     = lipgloss.Color("209") // Coral/orange for selected items
	transparentGray = lipgloss.Color("240") // Darker gray for descriptions

	// Styles
	titleStyle = lipgloss.NewStyle().
			Bold(true).
			Foreground(primaryColor).
			Align(lipgloss.Center).
			MarginBottom(1)

	menuBoxStyle = lipgloss.NewStyle().
			BorderStyle(lipgloss.RoundedBorder()).
			BorderForeground(borderColor).
			Padding(1, 2)

	selectedItemStyle = lipgloss.NewStyle().
				Foreground(coralOrange).
				Bold(true)

	normalItemStyle = lipgloss.NewStyle().
			Foreground(lipgloss.Color("252"))

	helpStyle = lipgloss.NewStyle().
			Foreground(subtleColor).
			MarginTop(1).
			Align(lipgloss.Center).
			Italic(true)

	descriptionStyle = lipgloss.NewStyle().
				Foreground(lipgloss.Color("240")).
				Inline(true)
)

// bubbleMenuModel is the Bubbletea model for SimpleMenu
type bubbleMenuModel struct {
	title        string
	options      []Option
	selected     int
	routeStack   []string
	params       []interface{}
	backFunction func(routeStack []string) ([]string, error)

	// Result to return
	result     []string
	err        error
	shouldQuit bool
}

func (m bubbleMenuModel) Init() tea.Cmd {
	return nil
}

func (m bubbleMenuModel) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	switch msg := msg.(type) {
	case tea.KeyMsg:
		switch msg.String() {
		case "ctrl+c":
			m.shouldQuit = true
			m.result = []string{}
			return m, tea.Quit

		case "up", "k":
			if m.selected > 0 {
				m.selected--
			}

		case "down", "j":
			if m.selected < len(m.options)-1 {
				m.selected++
			}

		case "enter":
			// Execute selected option
			if m.selected >= 0 && m.selected < len(m.options) {
				newRouteStack, err := m.options[m.selected].Action(m.params...)
				m.result = newRouteStack
				m.err = err
				m.shouldQuit = true
				return m, tea.Quit
			}

		case "b", "esc":
			// Back function
			if m.backFunction != nil {
				newRouteStack, err := m.backFunction(m.routeStack)
				m.result = newRouteStack
				m.err = err
				m.shouldQuit = true
				return m, tea.Quit
			}
			// Default back behavior
			if len(m.routeStack) > 0 {
				m.result = m.routeStack[:len(m.routeStack)-1]
			} else {
				m.result = m.routeStack
			}
			m.shouldQuit = true
			return m, tea.Quit

		case "m":
			// Map command - return empty route stack
			m.result = []string{}
			m.shouldQuit = true
			return m, tea.Quit

		case "1", "2", "3", "4", "5", "6", "7", "8", "9":
			// Numeric selection
			num := int(msg.String()[0] - '0')
			if num >= 1 && num <= len(m.options) {
				m.selected = num - 1
				newRouteStack, err := m.options[m.selected].Action(m.params...)
				m.result = newRouteStack
				m.err = err
				m.shouldQuit = true
				return m, tea.Quit
			}
		}
	}

	return m, nil
}

func (m bubbleMenuModel) View() string {
	if m.shouldQuit {
		return ""
	}

	var content strings.Builder

	// Title at the top
	content.WriteString(titleStyle.Render(m.title))
	content.WriteString("\n\n")

	// Build menu items
	var menuItems strings.Builder

	// First pass: calculate max width for option names to align descriptions
	maxNameWidth := 0
	for i, opt := range m.options {
		// Calculate width using actual cursor format
		cursor := "  "
		namePart := fmt.Sprintf("%s%d. %s", cursor, i+1, opt.Name)
		nameWidth := len(namePart)
		if nameWidth > maxNameWidth {
			maxNameWidth = nameWidth
		}
	}

	// Second pass: render items with aligned descriptions
	for i, opt := range m.options {
		// Always calculate width based on normal cursor (2 spaces)
		normalCursor := "  "
		normalNamePart := fmt.Sprintf("%s%d. %s", normalCursor, i+1, opt.Name)
		normalWidth := len(normalNamePart)

		// Build actual display cursor
		cursor := "  "
		if i == m.selected {
			cursor = "▶ "
		}
		namePart := fmt.Sprintf("%s%d. %s", cursor, i+1, opt.Name)

		// Calculate padding based on normal width (so selected items get extra space)
		padding := maxNameWidth - normalWidth
		if padding < 0 {
			padding = 0
		}

		// Build description part (always visible, in gray)
		descPart := ""
		if opt.Description != "" {
			descPart = strings.Repeat(" ", padding+2) + descriptionStyle.Render(opt.Description)
		}

		if i == m.selected {
			// Selected: coral/orange name + gray description
			styledName := selectedItemStyle.Render(namePart)
			menuItems.WriteString(styledName + descPart)
		} else {
			// Normal: white name + gray description
			styledName := normalItemStyle.Render(namePart)
			menuItems.WriteString(styledName + descPart)
		}

		menuItems.WriteString("\n")
	}

	// Add menu items directly (no box wrapper)
	content.WriteString(menuItems.String())
	content.WriteString("\n")

	// Help text at the bottom
	content.WriteString(helpStyle.Render("↑/↓: navigate • 1-9: quick select • enter: choose • b/esc: back • m: map"))

	return content.String()
}

// SimpleMenu is a Bubbletea-powered menu for simple option selection
type SimpleMenu struct {
	Title        string
	Options      []Option
	BackFunction func(routeStack []string) ([]string, error)
}

// Show implements the Menu interface using Bubbletea
func (m *SimpleMenu) Show(routeStack []string, params ...interface{}) ([]string, error) {
	model := bubbleMenuModel{
		title:        m.Title,
		options:      m.Options,
		selected:     0,
		routeStack:   routeStack,
		params:       params,
		backFunction: m.BackFunction,
	}

	p := tea.NewProgram(model)
	finalModel, err := p.Run()
	if err != nil {
		return routeStack, fmt.Errorf("bubbletea error: %w", err)
	}

	// Extract result from final model
	if final, ok := finalModel.(bubbleMenuModel); ok {
		if final.err != nil {
			// If the action returned an error, we still want to show it to the user
			// but then return to the appropriate menu
			fmt.Printf("\nError: %v\nPress any key to continue...", final.err)
			GetInput()
			return []string{}, nil
		}
		return final.result, nil
	}

	return routeStack, nil
}
