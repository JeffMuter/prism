package db

import (
	"prism/db"
	"testing"
)

func TestDatabaseConnection(t *testing.T) {
	testDB := db.NewTestDB(t)

	var count int
	err := testDB.QueryRow("SELECT COUNT(*) FROM users").Scan(&count)
	if err != nil {
		t.Fatalf("Failed to query users: %v", err)
	}

	t.Logf("Users in database: %d\n", count)
}
