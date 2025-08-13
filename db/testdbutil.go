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

// TestDBOptions configures test database creation
type TestDBOptions struct {
	// SkipSeedData skips loading the large seed data migration (recommended for most tests)
	SkipSeedData bool
	// SetupBasicData automatically creates basic reference data (location_types, resources, etc.)
	SetupBasicData bool
}

// NewTestDB creates a test database with default options (no seed data, with basic data)
func NewTestDB(t *testing.T) *sql.DB {
	return NewTestDBWithOptions(t, TestDBOptions{
		SkipSeedData:   true,
		SetupBasicData: true,
	})
}

// NewTestDBWithSeedData creates a test database with full seed data (for integration tests)
func NewTestDBWithSeedData(t *testing.T) *sql.DB {
	return NewTestDBWithOptions(t, TestDBOptions{
		SkipSeedData:   false,
		SetupBasicData: false, // seed data includes this
	})
}

// NewTestDBWithOptions creates a test database with custom options
func NewTestDBWithOptions(t *testing.T, opts TestDBOptions) *sql.DB {
	t.Helper()

	// Create in-memory database
	db, err := sql.Open("sqlite3", ":memory:")
	if err != nil {
		t.Fatalf("Failed to open test database: %v", err)
	}

	// Use consistent pragmas with production, but optimized for testing
	pragmas := []string{
		"PRAGMA foreign_keys = ON",
		"PRAGMA journal_mode = MEMORY", // Memory journal for tests
		"PRAGMA synchronous = OFF",     // Faster for tests
		"PRAGMA cache_size = 10000",    // Larger cache for tests
		"PRAGMA temp_store = memory",
		"PRAGMA busy_timeout = 5000",
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

	if opts.SkipSeedData {
		// Run only schema migrations, skip seed data
		if err := runSchemaOnly(db); err != nil {
			t.Fatalf("Failed to run schema migrations: %v", err)
		}
	} else {
		// Run all migrations including seed data
		if err := goose.Up(db, "migrations"); err != nil {
			t.Fatalf("Failed to run migrations: %v", err)
		}
	}

	// Setup basic reference data if requested
	if opts.SetupBasicData {
		fixtures := NewTestFixtures(t, db)
		fixtures.SetupBasicData()
	}

	// Cleanup when test finishes
	t.Cleanup(func() {
		db.Close()
	})

	return db
}

// runSchemaOnly runs only the schema migrations, skipping seed data
func runSchemaOnly(db *sql.DB) error {
	// For now, just run all migrations - the performance difference in tests isn't critical
	// TODO: In the future, move seed data out of migrations entirely
	return goose.Up(db, "migrations")
}
