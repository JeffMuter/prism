package db

import (
	"database/sql"
	"embed"
	"testing"

	_ "github.com/mattn/go-sqlite3"
	"github.com/pressly/goose/v3"
)

//go:embed migrations/*.sql
var migrations embed.FS

//go:embed scripting/db-setup.sql
var seedData embed.FS

func NewTestDB(t *testing.T) *sql.DB {
	t.Helper()

	// Create in-memory database
	db, err := sql.Open("sqlite3", ":memory:")
	if err != nil {
		t.Fatalf("Failed to open test database: %v", err)
	}

	// Optimize for testing
	pragmas := []string{
		"PRAGMA synchronous = OFF",
		"PRAGMA journal_mode = MEMORY",
		"PRAGMA foreign_keys = ON",
		"PRAGMA cache_size = 10000",
	}

	for _, pragma := range pragmas {
		if _, err := db.Exec(pragma); err != nil {
			t.Fatalf("Failed to execute %s: %v", pragma, err)
		}
	}

	// Set connection limits for in-memory database
	db.SetMaxIdleConns(1)
	db.SetConnMaxLifetime(0)
	db.SetMaxOpenConns(1)

	// Run migrations
	goose.SetBaseFS(migrations)
	if err := goose.SetDialect("sqlite3"); err != nil {
		t.Fatalf("Failed to set dialect: %v", err)
	}

	if err := goose.Up(db, "db/migrations"); err != nil {
		t.Fatalf("Failed to run migrations: %v", err)
	}

	// Seed with initial data
	seedSQL, err := seedData.ReadFile("db/scripting/db-setup.sql")
	if err != nil {
		t.Fatalf("Failed to read seed data: %v", err)
	}

	if _, err := db.Exec(string(seedSQL)); err != nil {
		t.Fatalf("Failed to seed database: %v", err)
	}

	// Cleanup when test finishes
	t.Cleanup(func() {
		db.Close()
	})

	return db
}
