package menus

import (
	"testing"
)

func TestIsHelpCommand(t *testing.T) {
	tests := []struct {
		input    string
		expected bool
	}{
		{"?", true},
		{"help", true},
		{"HELP", true},
		{"h", true},
		{"H", true},
		{"  ? ", true},
		{"ping", false},
		{"", false},
		{"help me", false},
	}

	for _, tt := range tests {
		result := IsHelpCommand(tt.input)
		if result != tt.expected {
			t.Errorf("IsHelpCommand(%q) = %v, want %v", tt.input, result, tt.expected)
		}
	}
}

func TestMainMenuHelp(t *testing.T) {
	helpProvider := MainMenuHelp{}
	help := NewMenuHelp(helpProvider)

	// Test that help provider returns expected commands
	commands := helpProvider.GetCommands()
	if len(commands) == 0 {
		t.Error("Expected main menu to have commands, got 0")
	}

	// Test that help command is handled
	if !help.HandleHelpCommand("?") {
		t.Error("Expected help command '?' to be handled")
	}

	if help.HandleHelpCommand("ping") {
		t.Error("Expected non-help command 'ping' to not be handled")
	}
}

func TestWorkerMenuHelp(t *testing.T) {
	helpProvider := WorkerMenuHelp{}
	commands := helpProvider.GetCommands()

	expectedCommands := []string{"move", "assign", "swap"}
	if len(commands) != len(expectedCommands) {
		t.Errorf("Expected %d commands, got %d", len(expectedCommands), len(commands))
	}

	for _, expected := range expectedCommands {
		found := false
		for _, cmd := range commands {
			if cmd.Name == expected {
				found = true
				break
			}
		}
		if !found {
			t.Errorf("Expected command %q not found in worker menu help", expected)
		}
	}
}

func TestMenuName(t *testing.T) {
	mainHelp := MainMenuHelp{}
	if mainHelp.GetMenuName() != "Main Menu" {
		t.Errorf("Expected main menu name 'Main Menu', got %q", mainHelp.GetMenuName())
	}

	workerHelp := WorkerMenuHelp{}
	if workerHelp.GetMenuName() != "Worker Menu" {
		t.Errorf("Expected worker menu name 'Worker Menu', got %q", workerHelp.GetMenuName())
	}
}