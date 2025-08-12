package menus

import (
	"prism/db"
	"testing"
)

func TestMainMenuListen(t *testing.T) {
	testDB := db.NewTestDB(t)
	db.SetDatabase(testDB)

	// TODO: This test requires refactoring MainMenuListen to accept an input interface
	// instead of reading directly from stdin via util.ReadCommandInput().
	// To make this testable, we need to:
	// 1. Create an input reader interface
	// 2. Modify MainMenuListen to accept the interface as a parameter
	// 3. Implement a mock reader for testing
	t.Skip("MainMenuListen requires interactive input - needs refactoring for testability")
}
