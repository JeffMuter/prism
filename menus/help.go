package menus

import (
	"fmt"
	"sort"
	"strings"
)

// Command represents a menu command with its help text
type Command struct {
	Name        string
	Description string
	Usage       string // Optional usage example
}

// HelpProvider defines the interface for any menu that can provide help
type HelpProvider interface {
	GetCommands() []Command
	GetMenuName() string
}

// MenuHelp provides universal help functionality for any menu
type MenuHelp struct {
	provider HelpProvider
}

// NewMenuHelp creates a new help system for a menu
func NewMenuHelp(provider HelpProvider) *MenuHelp {
	return &MenuHelp{provider: provider}
}

// ShowHelp displays help for the current menu
func (h *MenuHelp) ShowHelp() {
	commands := h.provider.GetCommands()
	menuName := h.provider.GetMenuName()

	fmt.Printf("\n=== %s Help ===\n", menuName)
	fmt.Println("Available commands:")

	// Sort commands alphabetically for consistent display
	sort.Slice(commands, func(i, j int) bool {
		return commands[i].Name < commands[j].Name
	})

	// Find the longest command name for formatting
	maxLen := 0
	for _, cmd := range commands {
		if len(cmd.Name) > maxLen {
			maxLen = len(cmd.Name)
		}
	}

	// Display commands with aligned descriptions
	for _, cmd := range commands {
		padding := strings.Repeat(" ", maxLen-len(cmd.Name)+2)
		fmt.Printf("  %s%s- %s\n", cmd.Name, padding, cmd.Description)
		if cmd.Usage != "" {
			fmt.Printf("  %s%s  Usage: %s\n", strings.Repeat(" ", len(cmd.Name)), padding, cmd.Usage)
		}
	}

	// Always include the help command itself
	fmt.Printf("  ?%s- Show this help menu\n", strings.Repeat(" ", maxLen-1+2))
	fmt.Println()
}

// IsHelpCommand checks if the input is a help request
func IsHelpCommand(input string) bool {
	trimmed := strings.TrimSpace(strings.ToLower(input))
	return trimmed == "?" || trimmed == "help" || trimmed == "h"
}

// HandleHelpCommand handles help command input and returns true if it was a help command
func (h *MenuHelp) HandleHelpCommand(input string) bool {
	if IsHelpCommand(input) {
		h.ShowHelp()
		return true
	}
	return false
}