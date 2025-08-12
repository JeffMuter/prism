package locations

import (
	"prism/db"
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
