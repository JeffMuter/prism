package locations

import (
	"errors"
	"fmt"
	"prism/database"
	"prism/util"
	"time"
)

type Resource struct {
	locationResourceId int
	name               string
	lastUpdated        time.Time
	quantity           int
	baseRate           float64
}

func GetNamesForResourcesOfTasksFromLocation(id int) ([]Resource, error) {

	var resources []Resource

	db := database.GetDB()
	query := `SELECT r.name, ttr.base_rate 
	FROM workers_tasks wt 
	JOIN task_types tt ON wt.task_type_id = tt.id 
	JOIN task_types_resources ttr ON tt.id = ttr.task_type_id 
	JOIN resources r ON ttr.resource_id = r.id 
	WHERE wt.location_id = $1 
	AND wt.is_ongoing = TRUE;`

	rows, err := db.Query(query, id)
	if err != nil {
		return resources, errors.New("failed to selects resource names from ongoing tasks related to locationId")
	}

	for rows.Next() {
		var resource Resource
		err = rows.Scan(&resource.name, &resource.baseRate)
		if err != nil {
			return resources, errors.New("error scanning rows in GetResourcesFromLocationIdForUpdating")
		}
		resources = append(resources, resource)
	}

	return resources, nil
}

// GetResourceDataByLocationId takes a location id as an int, and fills all the fields of a resource, returning a slice of them.
func GetResourceDataByLocationId(locId int) ([]Resource, error) {
	var resources []Resource

	db := database.GetDB()
	query := `SELECT r.id, r.name, lr.quantity, lr.last_updated 
	FROM locations_resources lr 
	JOIN resources r ON r.id = lr.resource_id 
	WHERE lr.location_id = $1;`

	rows, err := db.Query(query, locId)
	if err != nil {
		return resources, errors.New("issue querying db for values from getting resources by location id")
	}

	for rows.Next() {
		var resource Resource
		err := rows.Scan(&resource.locationResourceId, &resource.name, &resource.quantity, &resource.lastUpdated)
		if err != nil {
			return resources, fmt.Errorf("error scanning resource fields from row: %w,", err)
		}
		resources = append(resources, resource)
	}

	return resources, nil
}

// UpdateLocationResources updates the locations_resources table, for each entry of this location. Adds new rows for each resource with a value, not yet on the table
func UpdateLocationResources(locationId int, resources []Resource) error {
	// remove the element if the quantity is 0 or less. If 0 or less, then we don't need to update the db with it.
	for i, resource := range resources {
		if resource.quantity < 1 {
			beforeIndex := resources[:i]
			afterIndex := resources[:i+1]
			resources = append(beforeIndex, afterIndex...)
		}
	}

	db := database.GetDB()
	query := `UPDATE locations_resources lr 
	SET last_updated = $1, quantity = $2 
	WHERE location_id = $3 
	AND resource_id = $4;`

	for _, resource := range resources {
		_, err := db.Exec(query, resource.lastUpdated, resource.quantity, locationId, resource.locationResourceId)
		if err != nil {
			return fmt.Errorf("could not update locations_resources: %w,", err)
		}
	}
	return nil
}

// CreateNewResources takes a loc id, and a slice of resources, and iinserts them into the db on locations_resources table, using fields of the resource to populate the db info. Specifically to only be used on new resources that currently don't exist for this locations
func CreateNewResources(locationId int, resources []Resource) error {
	db := database.GetDB()
	query := `INSERT INTO locations_resources 
	(location_id, resource_id, last_updated, quantity) 
	VALUES ($1, $2, $3, $4)`
	for i := range resources {
		_, err := db.Exec(query, locationId, resources[i].locationResourceId, resources[i].lastUpdated, resources[i].quantity)
		if err != nil {
			return fmt.Errorf("error inserting locations_resources row to db: %w", err)
		}
	}
	return nil
}

// GetResourceIdByName takes in a string which references a Resource type, and returns the id of the Resource
func GetResourceIdByName(name string) (int, error) {
	var id = 0

	db := database.GetDB()
	query := `SELECT id 
	FROM resources 
	WHERE name = $1`
	row := db.QueryRow(query, name)
	err := row.Scan(&id)
	if err != nil {
		return id, fmt.Errorf("error scanning sql row while getting resource id from name string: %w,", err)
	}
	return id, nil
}

// FindMissingLocationResources()
func FindMissingLocationResources(potentialResources map[string]float64, existingResources []Resource) ([]Resource, error) {

	var newResources []Resource // for the resources that are not in the db yet, so we can add them seperately

	// we need to make resources, for each potential resource not currently in resource slice.
	for resourceName, rate := range potentialResources {
		var found bool
		for _, resource := range existingResources {
			if resource.name == resourceName {
				found = true
				break
			}
		}
		if !found { // if not found, make an add a new resource to the slice of existing.
			var resourceId int
			resourceId, err := GetResourceIdByName(resourceName)
			if err != nil {
				return newResources, fmt.Errorf("error getting a resource's Id by using its name (name: %s): %w,", resourceName, err)
			}

			// cannot leave baseRate at 0... TODO
			newResource := Resource{resourceId, resourceName, time.Now().UTC(), 0, rate}
			newResources = append(newResources, newResource)
		}
	}
	return newResources, nil
}

// CalculateEarnings taking in the number of minutes passed, and a list of resources
func CalculateEarnings(resourcesWithMinutes map[Resource]int) []Resource {
	randTime := util.InitializeTime()
	var resources []Resource
	for resource, minutes := range resourcesWithMinutes {
		for i := 0; i < minutes; i++ {
			if randTime.Float64() < resource.baseRate {
				resource.quantity++
			}
		}
		resources = append(resources, resource)
	}

	return resources
}

func CalculateMinutesPassedFromLastUpdate(resources []Resource) map[Resource]int {

	var mapResourceMin = make(map[Resource]int)
	now := time.Now().UTC()

	for _, resource := range resources {
		timePassed := now.Sub(resource.lastUpdated)
		resource.lastUpdated = now // now done calc minutes since last update, set new time for this loc_res
		mapResourceMin[resource] = int(timePassed.Minutes())
	}
	return mapResourceMin
}

// AddRatesToResourcesFromMapResourceNameRate is a func that takes resources, and a map of resource name & rate of generation, and applies those to a resource, returning the corresponding slice
func AddRatesToResourcesFromMapResourceNameRate(resources []Resource, mapResourceRate map[string]float64) []Resource {
	for i := range resources {
		resources[i].baseRate = mapResourceRate[resources[i].name]
	}
	return resources
}

// SetResourceDetailsForLocations() func takes any num of Location type, and sets the resources for that Location, returning them as a slice.
func SetResourceDetailsForLocations(locs ...*Location) ([]Location, error) {
	var setLocs []Location

	for _, loc := range locs {
		locResources, err := GetResourceDataByLocationId(loc.Id)
		if err != nil {
			return setLocs, fmt.Errorf("error setting resources for loc (locId: %d): %w,", loc.Id, err)
		}
		loc.Resources = locResources
	}

	return setLocs, nil
}

// SetLocResources()
func SetLocResources(loc *Location, recs []Resource) error {
	loc.Resources = recs
	return nil
}
