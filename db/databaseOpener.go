package db

import (
	"database/sql"
	"fmt"
	"path/filepath"
	"prism/db/sqlc"

	_ "github.com/mattn/go-sqlite3"
)

var db *sql.DB
var queries *sqlc.Queries

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

func GetQueries() *sqlc.Queries {
	return queries
}
