package db

import (
	"database/sql"
	"fmt"
	"path/filepath"

	_ "github.com/mattn/go-sqlite3"
)

var db *sql.DB

func OpenDatabase() error {
	// Use relative path to database file
	dbPath := filepath.Join("db", "prism.db")

	var err error
	db, err = sql.Open("sqlite3", dbPath)
	if err != nil {
		return fmt.Errorf("error unable to connect to db: %w", err)
	}

	err = db.Ping()
	if err != nil {
		return fmt.Errorf("error pinging db: %w", err)
	}

	return configurePragmas(db)
}

// New function to set a database instance (for testing)
func SetDatabase(database *sql.DB) error {
	db = database
	return configurePragmas(db)
}

// Extract pragma configuration to reusable function
func configurePragmas(database *sql.DB) error {
	pragmas := []string{
		"PRAGMA foreign_keys = ON",
		"PRAGMA journal_mode = WAL",
		"PRAGMA synchronous = NORMAL",
		"PRAGMA cache_size = 1000",
		"PRAGMA temp_store = memory",
		"PRAGMA busy_timeout = 5000",
	}

	for _, pragma := range pragmas {
		if _, err := database.Exec(pragma); err != nil {
			return fmt.Errorf("error executing pragma %s: %w", pragma, err)
		}
	}

	err := database.Ping()
	if err != nil {
		return fmt.Errorf("error pinging db: %w", err)
	}

	return nil
}

func GetDB() *sql.DB {
	return db
}
