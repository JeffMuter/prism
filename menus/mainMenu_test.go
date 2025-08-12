package menus

import (
	"prism/db"
	"prism/user"
	"prism/util"
	"testing"
)

func TestMainMenuListen(t *testing.T) {
	testDB := db.NewTestDB(t)
	db.SetDatabase(testDB)

	// Create a test user
	testUser := user.User{
		Id:        1,
		Email:     "test@example.com",
		Password:  "testpass",
		Latitude:  41.4766201,
		Longitude: -81.5047772,
	}

	// Test the "ping" command
	t.Run("ping command", func(t *testing.T) {
		mockReader := util.NewMockReader([]string{"ping"})
		err := MainMenuListen(testUser, mockReader)
		if err != nil {
			t.Errorf("MainMenuListen with 'ping' command failed: %v", err)
		}
	})

	// Test invalid command
	t.Run("invalid command", func(t *testing.T) {
		mockReader := util.NewMockReader([]string{"invalid_command"})
		err := MainMenuListen(testUser, mockReader)
		if err == nil {
			t.Error("Expected error for invalid command, but got nil")
		}
		if err != nil && err.Error() != "invalid input: invalid_command," {
			t.Errorf("Expected specific error message, got: %v", err)
		}
	})
}
