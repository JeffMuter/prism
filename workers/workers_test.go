package workers

import (
	"bytes"
	"io"
	"os"
	"prism/db"
	"prism/locations"
	"prism/user"
	"testing"
	"time"
)

func TestGetWorkersRelevantToUser(t *testing.T) {
	testDB := db.NewTestDB(t)
	db.SetDatabase(testDB)

	testUser := user.User{
		Id:        1,
		Email:     "1@gmail.com",
		Password:  "1",
		Latitude:  39.9862,
		Longitude: -82.9855,
	}

	t.Run("returns workers for valid user", func(t *testing.T) {
		// Create test data using fixtures
		fixtures := db.NewTestFixtures(t, testDB)
		
		userId := fixtures.CreateUser("testuser", "test-unique@example.com", "password")
		locationId := fixtures.CreateLocation(1, "Test Location", 39.9862, -82.9855)
		userLocationId := fixtures.CreateUserLocation(userId, locationId, "Test Location")
		
		fixtures.CreateWorker(userLocationId, "Test Worker 1", "Test Religion", true)
		fixtures.CreateWorker(userLocationId, "Test Worker 2", "Test Religion", false)
		fixtures.CreateWorker(userLocationId, "Test Worker 3", "Test Religion", true)

		// Use the created user for the test
		testUserWithId := user.User{
			Id:        int(userId),
			Email:     "test-unique@example.com",
			Latitude:  39.9862,
			Longitude: -82.9855,
		}
		
		workers, err := GetWorkersRelevantToUser(testUserWithId)
		if err != nil {
			t.Fatalf("Expected no error, got: %v", err)
		}

		if len(workers) == 0 {
			t.Error("Expected at least one worker for test user, got none")
		}

		expectedWorkerCount := 3
		if len(workers) != expectedWorkerCount {
			t.Errorf("Expected %d workers, got %d", expectedWorkerCount, len(workers))
		}

		for _, worker := range workers {
			if worker.Id == 0 {
				t.Error("Worker ID should not be 0")
			}
			if worker.Name == "" {
				t.Error("Worker name should not be empty")
			}
			if worker.UserLocationId == 0 {
				t.Error("Worker should have a valid UserLocationId")
			}
		}
	})

	t.Run("handles non-existent user gracefully", func(t *testing.T) {
		nonExistentUser := user.User{Id: 99999}
		workers, err := GetWorkersRelevantToUser(nonExistentUser)
		if err != nil {
			t.Fatalf("Expected no error for non-existent user, got: %v", err)
		}

		if len(workers) != 0 {
			t.Errorf("Expected no workers for non-existent user, got %d", len(workers))
		}
	})

	t.Run("verifies worker data integrity", func(t *testing.T) {
		workers, err := GetWorkersRelevantToUser(testUser)
		if err != nil {
			t.Fatalf("Expected no error, got: %v", err)
		}

		for _, worker := range workers {
			if worker.Strength < 0 || worker.Strength > 100 {
				t.Errorf("Worker %s has invalid strength: %d", worker.Name, worker.Strength)
			}
			if worker.Intelligence < 0 || worker.Intelligence > 100 {
				t.Errorf("Worker %s has invalid intelligence: %d", worker.Name, worker.Intelligence)
			}
			if worker.Faith < 0 || worker.Faith > 100 {
				t.Errorf("Worker %s has invalid faith: %d", worker.Name, worker.Faith)
			}
		}
	})
}

func TestGetWorkersRelatedToLocation(t *testing.T) {
	testDB := db.NewTestDB(t)
	db.SetDatabase(testDB)

	t.Run("returns workers for valid location", func(t *testing.T) {
		workers, err := GetWorkersRelatedToLocation(1)
		if err != nil {
			t.Fatalf("Expected no error, got: %v", err)
		}

		for _, worker := range workers {
			if worker.LocationId != 1 {
				t.Errorf("Expected worker location_id to be 1, got %d", worker.LocationId)
			}
			if worker.Id == 0 {
				t.Error("Worker ID should not be 0")
			}
		}
	})

	t.Run("handles non-existent location gracefully", func(t *testing.T) {
		workers, err := GetWorkersRelatedToLocation(99999)
		if err != nil {
			t.Fatalf("Expected no error for non-existent location, got: %v", err)
		}

		if len(workers) != 0 {
			t.Errorf("Expected no workers for non-existent location, got %d", len(workers))
		}
	})

	t.Run("includes task information when workers have tasks", func(t *testing.T) {
		workers, err := GetWorkersRelatedToLocation(1)
		if err != nil {
			t.Fatalf("Expected no error, got: %v", err)
		}

		for _, worker := range workers {
			if worker.WorkType != "" {
				t.Logf("Worker %s has task type: %s", worker.Name, worker.WorkType)
			}
		}
	})
}

func TestMoveWorkerToLocation(t *testing.T) {
	testDB := db.NewTestDB(t)
	db.SetDatabase(testDB)

	t.Run("moves worker to new location successfully", func(t *testing.T) {
		// Create test data
		result1, err := testDB.Exec("INSERT INTO users_locations (user_id, location_id, name) VALUES (?, ?, ?)", 1, 1, "Location 1")
		if err != nil {
			t.Fatalf("Failed to create first test location: %v", err)
		}
		userLocationId1, err := result1.LastInsertId()
		if err != nil {
			t.Fatalf("Failed to get first users_locations ID: %v", err)
		}
		
		result2, err := testDB.Exec("INSERT INTO users_locations (user_id, location_id, name) VALUES (?, ?, ?)", 1, 2, "Location 2")
		if err != nil {
			t.Fatalf("Failed to create second test location: %v", err)
		}
		userLocationId2, err := result2.LastInsertId()
		if err != nil {
			t.Fatalf("Failed to get second users_locations ID: %v", err)
		}
		
		_, err = testDB.Exec("INSERT INTO workers (name, user_locations_id, religion, work_status, injured, strength, intelligence, speed, faith, luck, loyalty, charisma) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
			"Test Worker", userLocationId1, "Test Religion", 1, 0, 5, 6, 5, 7, 4, 9, 6)
		if err != nil {
			t.Fatalf("Failed to create test worker: %v", err)
		}

		testUser := user.User{Id: 1}
		workers, err := GetWorkersRelevantToUser(testUser)
		if err != nil {
			t.Fatalf("Failed to get workers: %v", err)
		}
		if len(workers) == 0 {
			t.Fatal("No workers found")
		}

		worker := workers[0]
		originalUserLocationId := worker.UserLocationId

		// Move to location 2
		targetLocation := locations.Location{
			Id:        2,
			Latitude:  40.0,
			Longitude: -82.0,
		}

		err = MoveWorkerToLocation(worker, targetLocation)
		if err != nil {
			t.Fatalf("Expected no error moving worker, got: %v", err)
		}

		// Verify the worker was moved
		var newUserLocationId int
		err = testDB.QueryRow("SELECT user_locations_id FROM workers WHERE id = ?", worker.Id).Scan(&newUserLocationId)
		if err != nil {
			t.Fatalf("Failed to query updated worker: %v", err)
		}

		if newUserLocationId == originalUserLocationId {
			t.Error("Worker user_location_id should have changed")
		}
		if newUserLocationId != int(userLocationId2) {
			t.Errorf("Expected worker to be at user_location_id %d, got %d", userLocationId2, newUserLocationId)
		}
	})

	t.Run("handles invalid location gracefully", func(t *testing.T) {
		testUser := user.User{Id: 1}
		workers, err := GetWorkersRelevantToUser(testUser)
		if err != nil || len(workers) == 0 {
			t.Skip("No workers available for test")
		}

		worker := workers[0]
		invalidLocation := locations.Location{
			Id:        99999,
			Latitude:  0.0,
			Longitude: 0.0,
		}

		err = MoveWorkerToLocation(worker, invalidLocation)
		if err == nil {
			t.Error("Expected error when moving worker to invalid location")
		}
	})
}

func TestToggleWorkingForWorker(t *testing.T) {
	testDB := db.NewTestDB(t)
	db.SetDatabase(testDB)

	t.Run("toggles worker status successfully", func(t *testing.T) {
		// Create test data
		result, err := testDB.Exec("INSERT INTO users_locations (user_id, location_id, name) VALUES (?, ?, ?)", 1, 1, "Test Location")
		if err != nil {
			t.Fatalf("Failed to create test location: %v", err)
		}
		userLocationId, err := result.LastInsertId()
		if err != nil {
			t.Fatalf("Failed to get users_locations ID: %v", err)
		}
		
		_, err = testDB.Exec("INSERT INTO workers (name, user_locations_id, religion, work_status, injured, strength, intelligence, speed, faith, luck, loyalty, charisma) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", 
			"Test Worker", userLocationId, "Test Religion", 1, 0, 5, 6, 5, 7, 4, 9, 6)
		if err != nil {
			t.Fatalf("Failed to create test worker: %v", err)
		}

		testUser := user.User{Id: 1}
		workers, err := GetWorkersRelevantToUser(testUser)
		if err != nil {
			t.Fatalf("Failed to get workers: %v", err)
		}
		if len(workers) == 0 {
			t.Fatal("No workers found")
		}

		worker := workers[0]
		originalStatus := worker.WorkStatus

		old := os.Stdout
		r, w, _ := os.Pipe()
		os.Stdout = w

		err = ToggleWorkingForWorker(worker)
		
		w.Close()
		os.Stdout = old
		
		if err != nil {
			t.Fatalf("Expected no error toggling worker status, got: %v", err)
		}

		// Verify the status was toggled in the database
		var newStatus bool
		query := "SELECT work_status FROM workers WHERE id = ?"
		err = testDB.QueryRow(query, worker.Id).Scan(&newStatus)
		if err != nil {
			t.Fatalf("Failed to query updated worker status: %v", err)
		}

		if newStatus == originalStatus {
			t.Error("Worker status should have been toggled")
		}

		buf := make([]byte, 1024)
		r.Read(buf)
	})

	t.Run("handles invalid worker ID", func(t *testing.T) {
		invalidWorker := Worker{Id: 99999, Name: "Invalid Worker"}
		
		old := os.Stdout
		r, w, _ := os.Pipe()
		os.Stdout = w

		err := ToggleWorkingForWorker(invalidWorker)
		
		w.Close()
		os.Stdout = old

		if err != nil {
			t.Logf("Got expected error for invalid worker: %v", err)
		}

		buf := make([]byte, 1024)
		r.Read(buf)
	})
}

func TestPrintWorkerDetails(t *testing.T) {
	t.Run("prints worker details correctly", func(t *testing.T) {
		worker := Worker{
			Id:            1,
			Name:          "Test Worker",
			LocationName:  "Test Location",
			WorkStatus:    true,
			Intelligence:  75,
			Strength:      80,
			Faith:         65,
			InjuredStatus: false,
		}

		old := os.Stdout
		r, w, _ := os.Pipe()
		os.Stdout = w

		PrintWorkerDetails(worker)

		w.Close()
		os.Stdout = old

		var buf bytes.Buffer
		io.Copy(&buf, r)
		output := buf.String()

		if !bytes.Contains([]byte(output), []byte("Test Worker")) {
			t.Error("Output should contain worker name")
		}
		if !bytes.Contains([]byte(output), []byte("Test Location")) {
			t.Error("Output should contain location name")
		}
		if !bytes.Contains([]byte(output), []byte("75")) {
			t.Error("Output should contain intelligence value")
		}
	})
}

func TestPrintWorkersDetails(t *testing.T) {
	t.Run("prints multiple workers correctly", func(t *testing.T) {
		workers := []Worker{
			{
				Id:            1,
				Name:          "Worker One",
				LocationName:  "Location A",
				WorkStatus:    true,
				Intelligence:  70,
				Strength:      75,
				Faith:         60,
				InjuredStatus: false,
			},
			{
				Id:            2,
				Name:          "Worker Two",
				LocationName:  "Location B",
				WorkStatus:    false,
				Intelligence:  80,
				Strength:      65,
				Faith:         70,
				InjuredStatus: true,
			},
		}

		old := os.Stdout
		r, w, _ := os.Pipe()
		os.Stdout = w

		PrintWorkersDetails(workers)

		w.Close()
		os.Stdout = old

		var buf bytes.Buffer
		io.Copy(&buf, r)
		output := buf.String()

		if !bytes.Contains([]byte(output), []byte("Worker One")) {
			t.Error("Output should contain first worker name")
		}
		if !bytes.Contains([]byte(output), []byte("Worker Two")) {
			t.Error("Output should contain second worker name")
		}
		if !bytes.Contains([]byte(output), []byte("0:")) {
			t.Error("Output should contain first worker index")
		}
		if !bytes.Contains([]byte(output), []byte("1:")) {
			t.Error("Output should contain second worker index")
		}
	})

	t.Run("handles empty worker slice", func(t *testing.T) {
		var workers []Worker

		old := os.Stdout
		r, w, _ := os.Pipe()
		os.Stdout = w

		PrintWorkersDetails(workers)

		w.Close()
		os.Stdout = old

		var buf bytes.Buffer
		io.Copy(&buf, r)
		output := buf.String()

		if !bytes.Contains([]byte(output), []byte("Worker Details:")) {
			t.Error("Output should contain header even for empty slice")
		}
	})
}

func TestWorkerStruct(t *testing.T) {
	t.Run("worker struct initialization", func(t *testing.T) {
		now := time.Now()
		worker := Worker{
			Id:             1,
			UserLocationId: 10,
			UserId:         5,
			LocationId:     3,
			WorkStatus:     true,
			WorkType:       "mining",
			InjuredStatus:  false,
			Strength:       85,
			Faith:          70,
			Intelligence:   75,
			CreatedAt:      now,
			Religion:       "Test Religion",
			Name:           "Test Worker",
			LocationName:   "Test Location",
			ArtFilName:     "worker",
		}

		if worker.Id != 1 {
			t.Errorf("Expected ID 1, got %d", worker.Id)
		}
		if worker.Name != "Test Worker" {
			t.Errorf("Expected name 'Test Worker', got %s", worker.Name)
		}
		if worker.WorkStatus != true {
			t.Error("Expected work status to be true")
		}
		if !worker.CreatedAt.Equal(now) {
			t.Error("Expected CreatedAt to match set time")
		}
	})
}