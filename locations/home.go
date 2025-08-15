package locations

import (
	"fmt"
	"prism/db"
)

// SetHomeLocation(userLocationId int) handles the whole system of setting a location to be the home location... Setting location type to 'home', and adds new home to homes table
func SetHomeLocation(userLoc *Location, homeName string) error {
	if !userLoc.IsUserCreated {
		fmt.Println("this location is not a location you created, and cannot become your 'home' location...")
		return fmt.Errorf("error this location is a global location, and its location type cannot be changed")
	}

	// if home is too close to another, then it doesn't work
	// get location of all current homes, then determine if user is currently too close
	homeLocations, err := getHomeLocationsForUser(userLoc.UserLocationId)
	if err != nil {
		return fmt.Errorf("error getting home locations for user: %w", err)
	}

	// Check if new home location is at least 600 miles (965.6 km) from existing homes
	const minHomeDistanceKm = 965.6 // 600 miles in kilometers
	for _, home := range homeLocations {
		isTooClose, err := isLocationTooClose(*userLoc, home, minHomeDistanceKm)
		if err != nil {
			return fmt.Errorf("error checking distance to existing home: %w", err)
		}
		if isTooClose {
			return fmt.Errorf("cannot create home location: too close to existing home '%s' (minimum distance is 600 miles)", home.Name.String)
		}
	}

	db := db.GetDB()

	// this can't occur like this.
	query := `UPDATE locations SET location_type_id = 10 WHERE id = ?`

	_, err = db.Exec(query, userLoc.Id)
	if err != nil {
		return fmt.Errorf("error executing query to make loc a home type: %w,", err)
	}

	query = `UPDATE users_locations ul SET name= ? WHERE ul.location_id= ?`

	_, err = db.Exec(query, homeName, userLoc.Id)

	err = addHome(userLoc.UserLocationId, homeName)
	if err != nil {
		return fmt.Errorf("error adding home to db: %w,", err)
	}

	return nil
}

func addHome(userLocationId int, homeName string) error {
	db := db.GetDB()

	query := `INSERT INTO homes (user_location_id, name) VALUES (?, ?)`

	_, err := db.Exec(query, userLocationId, homeName)
	if err != nil {
		return fmt.Errorf("error executing query to insert new home into db: %w", err)
	}

	return nil
}

// getHomeLocationsForUser gets all home locations (location_type_id = 10) for a user
func getHomeLocationsForUser(userLocationId int) ([]Location, error) {
	var homeLocations []Location
	db := db.GetDB()

	// Get user_id from user_location_id to find all their locations
	var userId int
	userQuery := `SELECT user_id FROM users_locations WHERE id = ?`
	err := db.QueryRow(userQuery, userLocationId).Scan(&userId)
	if err != nil {
		return homeLocations, fmt.Errorf("error getting user_id from user_location_id: %w", err)
	}

	// Get all home locations for this user
	query := `SELECT 
		l.id, 
		ul.id,
		l.latitude, 
		l.longitude, 
		ul.name
	FROM locations l
	JOIN users_locations ul ON l.id = ul.location_id 
	WHERE ul.user_id = ? AND l.location_type_id = 10`

	rows, err := db.Query(query, userId)
	if err != nil {
		return homeLocations, fmt.Errorf("error querying home locations: %w", err)
	}
	defer rows.Close()

	for rows.Next() {
		var location Location
		err := rows.Scan(&location.Id, &location.UserLocationId, &location.Latitude, &location.Longitude, &location.Name)
		if err != nil {
			return homeLocations, fmt.Errorf("error scanning home location row: %w", err)
		}
		homeLocations = append(homeLocations, location)
	}

	return homeLocations, nil
}
