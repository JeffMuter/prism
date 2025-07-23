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

	db, err := sql.Open("sqlite3", dbPath)
	if err != nil {
		return fmt.Errorf("error unable to connect to db: %w", err)
	}

	// Enable foreign keys for this connection
	_, err = db.Exec("PRAGMA foreign_keys = ON")
	if err != nil {
		return fmt.Errorf("error enabling foreign keys: %w", err)
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
