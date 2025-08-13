package locations

import (
	"prism/db"
	"prism/user"
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
		Latitude:  50.0000,
		Longitude: -100.0000,
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
		_, err := CreateLocation(testUser, "Too Close Node", 1)
		if err == nil {
			t.Fatalf("expected error for location too close to existing, got nil")
		}
		if err.Error() != "node location too close to another: Test Node" {
			t.Fatalf("unexpected error message: %v", err)
		}
	})

	t.Run("location creation with different coordinates", func(t *testing.T) {
		farUser := user.User{
			Id:        1,
			Username:  "testuser",
			Email:     "test@example.com",
			Latitude:  52.0000,
			Longitude: -102.0000,
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
		Latitude:  51.0000,
		Longitude: -101.0000,
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
