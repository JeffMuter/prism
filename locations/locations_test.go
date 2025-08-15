package locations

import (
	"prism/db"
	"prism/user"
	"strings"
	"testing"
	"time"
)

func TestGetResourceIdByName(t *testing.T) {
	testDB := db.NewTestDB(t)
	db.SetDatabase(testDB)

	resourceId, err := GetResourceIdByName("iron")
	if err != nil {
		t.Fatalf("expected no err, got: %v", err)
	} else if resourceId != 1 {
		t.Fatalf("expected 'iron' to have an id of 1 in resource table, got %d,", resourceId)
	}

	resourceId, err = GetResourceIdByName("ugachaka")
	if err == nil {
		t.Fatalf("tried to get an id from nonsense, didn't get an error from passing 'ugachaka', id returned: %d", resourceId)
	}
}

func TestCreateNewResources(t *testing.T) {
	testDB := db.NewTestDB(t)
	db.SetDatabase(testDB)

	_, err := testDB.Exec("DELETE FROM locations_resources WHERE location_id = ?", 1)
	if err != nil {
		t.Fatalf("failed to clear locations_resources table of location_id: %d: %v", 1, err)
	}

	now := time.Now()

	resources := []Resource{
		{
			locationResourceId: 1,
			name:               "Iron",
			lastUpdated:        now.Add(-12 * time.Hour),
			quantity:           10,
			baseRate:           2.5,
		},
		{
			locationResourceId: 2,
			name:               "Copper",
			lastUpdated:        now.Add(-24 * time.Hour),
			quantity:           20,
			baseRate:           1.8,
		},
	}
	err = CreateNewResources(1, resources)
	if err != nil {
		t.Fatalf("CreateNewResources failed: %v", err)
	}

}

func TestCreateLocation(t *testing.T) {
	testDB := db.NewTestDB(t)
	db.SetDatabase(testDB)

	testUser := user.User{
		Id:        1,
		Username:  "testuser",
		Email:     "test@example.com",
		Latitude:  89.9999,
		Longitude: 179.9999,
	}

	t.Run("successful location creation", func(t *testing.T) {
		userLocId, err := CreateLocation(testUser, "Test Node", 1)
		if err != nil {
			t.Fatalf("CreateLocation failed: %v", err)
		}
		if userLocId == 0 {
			t.Fatalf("expected non-zero user location ID, got %d", userLocId)
		}
	})

	t.Run("location too close to existing location", func(t *testing.T) {
		userLocId, err := CreateLocation(testUser, "Too Close Node", 1)
		if err != nil {
			t.Fatalf("unexpected error: %v", err)
		}
		if userLocId != 0 {
			t.Fatalf("expected userLocId to be 0 when location is too close, got %d", userLocId)
		}
	})

	t.Run("location creation with different coordinates", func(t *testing.T) {
		farUser := user.User{
			Id:        1,
			Username:  "testuser",
			Email:     "test@example.com",
			Latitude:  89.2000,
			Longitude: 0.2000,
		}
		
		userLocId, err := CreateLocation(farUser, "Far Node", 1)
		if err != nil {
			t.Fatalf("CreateLocation failed for far location: %v", err)
		}
		if userLocId == 0 {
			t.Fatalf("expected non-zero user location ID for far location, got %d", userLocId)
		}
	})
}

func TestGetLocationsForUser(t *testing.T) {
	testDB := db.NewTestDB(t)
	db.SetDatabase(testDB)

	testUser := user.User{
		Id:        1,
		Username:  "testuser",
		Email:     "test@example.com",
		Latitude:  -84.0000,
		Longitude: -179.0000,
	}

	userLocId, err := CreateLocation(testUser, "User Test Node", 1)
	if err != nil {
		t.Fatalf("setup: CreateLocation failed: %v", err)
	}

	t.Run("get locations for existing user", func(t *testing.T) {
		locations, err := GetLocationsForUser(testUser.Id)
		if err != nil {
			t.Fatalf("GetLocationsForUser failed: %v", err)
		}
		
		if len(locations) == 0 {
			t.Fatalf("expected at least one location, got %d", len(locations))
		}

		found := false
		for _, loc := range locations {
			if loc.UserLocationId == userLocId {
				found = true
				if loc.Name.String != "User Test Node" {
					t.Errorf("expected location name 'User Test Node', got '%s'", loc.Name.String)
				}
				if loc.LocationTypeId != 1 {
					t.Errorf("expected location type ID 1, got %d", loc.LocationTypeId)
				}
				if loc.IsUserCreated != true {
					t.Errorf("expected IsUserCreated to be true, got %v", loc.IsUserCreated)
				}
				break
			}
		}
		
		if !found {
			t.Fatalf("created location not found in GetLocationsForUser results")
		}
	})

	t.Run("get locations for non-existent user", func(t *testing.T) {
		locations, err := GetLocationsForUser(999)
		if err != nil {
			t.Fatalf("GetLocationsForUser failed for non-existent user: %v", err)
		}
		
		if len(locations) != 0 {
			t.Fatalf("expected no locations for non-existent user, got %d", len(locations))
		}
	})
}

func TestSetHomeLocation(t *testing.T) {
	testDB := db.NewTestDB(t)
	db.SetDatabase(testDB)

	testUser := user.User{
		Id:        1,
		Username:  "testuser",
		Email:     "test@example.com",
		Latitude:  -82.0000,
		Longitude: -179.0000,
	}

	t.Run("successful home location creation", func(t *testing.T) {
		userLocId, err := CreateLocation(testUser, "Test Home", 1)
		if err != nil {
			t.Fatalf("setup: CreateLocation failed: %v", err)
		}

		locations, err := GetLocationsForUser(testUser.Id)
		if err != nil {
			t.Fatalf("setup: GetLocationsForUser failed: %v", err)
		}

		var testLocation *Location
		for _, loc := range locations {
			if loc.UserLocationId == userLocId {
				testLocation = &loc
				break
			}
		}

		if testLocation == nil {
			t.Fatalf("setup: could not find created location")
		}

		err = SetHomeLocation(testLocation, "My Home")
		if err != nil {
			t.Fatalf("SetHomeLocation failed: %v", err)
		}

		var locationTypeId int
		query := `SELECT location_type_id FROM locations WHERE id = ?`
		err = testDB.QueryRow(query, testLocation.Id).Scan(&locationTypeId)
		if err != nil {
			t.Fatalf("failed to verify location type: %v", err)
		}

		if locationTypeId != 10 {
			t.Fatalf("expected location_type_id to be 10 (home), got %d", locationTypeId)
		}
	})

	t.Run("home location creation fails when too close to existing home", func(t *testing.T) {
		// Directly insert test locations into database to bypass CreateLocation proximity issues
		
		// Insert first location and make it a home
		query := `INSERT INTO locations (default_accessible, latitude, longitude, name, description, art, location_type_id, is_user_created) 
				  VALUES (0, 0.0, 0.0, 'First Home', 'test', 'test', 10, 1) RETURNING id`
		var firstLocId int
		err := testDB.QueryRow(query).Scan(&firstLocId)
		if err != nil {
			t.Fatalf("setup: failed to insert first location: %v", err)
		}

		query = `INSERT INTO users_locations (user_id, location_id, name) VALUES (1, ?, 'First Home') RETURNING id`
		var firstUserLocId int
		err = testDB.QueryRow(query, firstLocId).Scan(&firstUserLocId)
		if err != nil {
			t.Fatalf("setup: failed to insert first user_location: %v", err)
		}

		// Insert second location very close to first (0.001 degrees = ~100 meters, much less than 600 miles)
		query = `INSERT INTO locations (default_accessible, latitude, longitude, name, description, art, location_type_id, is_user_created) 
				  VALUES (0, 0.001, 0.001, 'Second Home', 'test', 'test', 1, 1) RETURNING id`
		var secondLocId int
		err = testDB.QueryRow(query).Scan(&secondLocId)
		if err != nil {
			t.Fatalf("setup: failed to insert second location: %v", err)
		}

		query = `INSERT INTO users_locations (user_id, location_id, name) VALUES (1, ?, 'Second Home') RETURNING id`
		var secondUserLocId int
		err = testDB.QueryRow(query, secondLocId).Scan(&secondUserLocId)
		if err != nil {
			t.Fatalf("setup: failed to insert second user_location: %v", err)
		}

		// Create Location object for second location
		secondLocation := &Location{
			Id:             secondLocId,
			UserLocationId: secondUserLocId,
			Latitude:       0.001,
			Longitude:      0.001,
			IsUserCreated:  true,
		}

		// Try to make second location a home - should fail due to proximity to first home
		err = SetHomeLocation(secondLocation, "Second Home")
		if err == nil {
			t.Fatalf("expected SetHomeLocation to fail due to proximity, but it succeeded")
		}

		expectedError := "cannot create home location: too close to existing home"
		if !strings.Contains(err.Error(), expectedError) {
			t.Fatalf("expected error containing '%s', got: %v", expectedError, err)
		}
	})
}
