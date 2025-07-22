package database

import (
	"testing"
)

func TestDatabaseConnection(t *testing.T) {
	err := OpenDatabase()
	if err != nil {
		t.Fatalf("Failed to open database: %v", err)
	}

	db := GetDB()

	var count int
	err = db.QueryRow("SELECT COUNT(*) FROM users").Scan(&count)
	if err != nil {
		t.Fatalf("Failed to query users: %v", err)
	}

	t.Logf("Users in database: %d\n", count)
}
