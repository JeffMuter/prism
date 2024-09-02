package locations

import (
	"prism/database"
	"testing"
)

func TestGetResourceIdByName(t *testing.T) {
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
	db := database.GetDB()
	tx, err := db.Begin()
	if err != nil {

	}
	defer db.Close()
	tx, err
}
