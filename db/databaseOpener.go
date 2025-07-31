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

	pragmas := []string{
		"PRAGMA foreign_keys = ON",
		"PRAGMA journal_mode = WAL",   // Write-Ahead Logging for better concurrency
		"PRAGMA synchronous = NORMAL", // Balance between safety and performance
		"PRAGMA cache_size = 1000",    // Increase cache size
		"PRAGMA temp_store = memory",  // Store temp tables in memory
		"PRAGMA busy_timeout = 5000",  // Wait up to 5 seconds for locks
	}

	for _, pragma := range pragmas {
		if _, err := db.Exec(pragma); err != nil {
			return fmt.Errorf("error executing pragma %s: %w", pragma, err)
		}
	}

	err = db.Ping()
	if err != nil {
		return fmt.Errorf("error pinging db: %w", err)
	}

	return nil
}

func GetDB() *sql.DB {
	return db
}
