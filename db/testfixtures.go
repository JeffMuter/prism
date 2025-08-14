package db

import (
	"database/sql"
	"testing"
)

// TestFixtures provides utilities for creating test data
type TestFixtures struct {
	db *sql.DB
	t  *testing.T
}

// NewTestFixtures creates a new test fixtures helper
func NewTestFixtures(t *testing.T, db *sql.DB) *TestFixtures {
	return &TestFixtures{
		db: db,
		t:  t,
	}
}

// CreateUser creates a test user and returns the ID
func (tf *TestFixtures) CreateUser(username, email, password string) int64 {
	tf.t.Helper()
	
	result, err := tf.db.Exec("INSERT INTO users (username, email, password) VALUES (?, ?, ?)", 
		username, email, password)
	if err != nil {
		tf.t.Fatalf("Failed to create test user: %v", err)
	}
	
	id, err := result.LastInsertId()
	if err != nil {
		tf.t.Fatalf("Failed to get user ID: %v", err)
	}
	
	return id
}

// CreateLocation creates a test location and returns the ID
func (tf *TestFixtures) CreateLocation(locationTypeId int, name string, lat, lng float64) int64 {
	tf.t.Helper()
	
	result, err := tf.db.Exec(`INSERT INTO locations (location_type_id, name, latitude, longitude, description, art) 
		VALUES (?, ?, ?, ?, ?, ?)`, 
		locationTypeId, name, lat, lng, "Test location", "default")
	if err != nil {
		tf.t.Fatalf("Failed to create test location: %v", err)
	}
	
	id, err := result.LastInsertId()
	if err != nil {
		tf.t.Fatalf("Failed to get location ID: %v", err)
	}
	
	return id
}

// CreateUserLocation creates a users_locations relationship and returns the ID
func (tf *TestFixtures) CreateUserLocation(userId, locationId int64, name string) int64 {
	tf.t.Helper()
	
	result, err := tf.db.Exec("INSERT INTO users_locations (user_id, location_id, name, worker_count) VALUES (?, ?, ?, ?)", 
		userId, locationId, name, 0)
	if err != nil {
		tf.t.Fatalf("Failed to create test user_location: %v", err)
	}
	
	id, err := result.LastInsertId()
	if err != nil {
		tf.t.Fatalf("Failed to get user_location ID: %v", err)
	}
	
	return id
}

// CreateWorker creates a test worker and returns the ID
func (tf *TestFixtures) CreateWorker(userLocationId int64, name, religion string, workStatus bool) int64 {
	tf.t.Helper()
	
	result, err := tf.db.Exec(`INSERT INTO workers (name, user_locations_id, religion, work_status, injured, strength, intelligence, speed, faith, luck, loyalty, charisma) 
		VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`, 
		name, userLocationId, religion, workStatus, false, 5, 6, 5, 7, 4, 9, 6)
	if err != nil {
		tf.t.Fatalf("Failed to create test worker: %v", err)
	}
	
	id, err := result.LastInsertId()
	if err != nil {
		tf.t.Fatalf("Failed to get worker ID: %v", err)
	}
	
	return id
}

// SetupBasicData creates minimal required reference data (location_types, etc.)
func (tf *TestFixtures) SetupBasicData() {
	tf.t.Helper()
	
	// Create basic location types that tests might need
	locationTypes := []string{"node", "mine", "farm", "lumber", "port", "forest", "mountain", "city", "outpost", "home"}
	for _, locType := range locationTypes {
		_, err := tf.db.Exec("INSERT OR IGNORE INTO location_types (name) VALUES (?)", locType)
		if err != nil {
			tf.t.Fatalf("Failed to create location type %s: %v", locType, err)
		}
	}
	
	// Create basic resources
	resources := []string{"iron", "copper", "wood", "stone", "food", "gold"}
	for _, resource := range resources {
		_, err := tf.db.Exec("INSERT OR IGNORE INTO resources (name) VALUES (?)", resource)
		if err != nil {
			tf.t.Fatalf("Failed to create resource %s: %v", resource, err)
		}
	}
	
	// Create basic task types
	taskTypes := []string{"mining", "woodcutting", "farming", "fishing", "exploring", "resting", "building", "traveling"}
	for _, taskType := range taskTypes {
		_, err := tf.db.Exec("INSERT OR IGNORE INTO task_types (name) VALUES (?)", taskType)
		if err != nil {
			tf.t.Fatalf("Failed to create task type %s: %v", taskType, err)
		}
	}
}