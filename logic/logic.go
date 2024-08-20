package logic

import (
	"fmt"
	"prism/locations"
	"prism/tasks"
)

// UpdateLocationResourcesQuantity is a function that takes in the id of a Location, and will update all of the locations_resources in the db, based on the tasks currently ongoing. Returns nil if successful.
func UpdateLocationResourcesQuantity(locationId int) error {

	// get names of all resources that the current tasks happening at this location could yield
	potentialResources, err := tasks.GetOngoingTaskNamesRateMapFromLocationId(locationId)
	if err != nil {
		return fmt.Errorf("error getting potential resources for a location based on its ongoing tasks: %v", err)
	}

	// get the quantities & last_updated from this locations_resources
	existingResources, err := locations.GetResourceDataByLocationId(locationId)
	if err != nil {
		return fmt.Errorf("problem getting existingResources, while updating location's resource quantities: %v", err)
	}

	// get a slice of empty resources to add
	unassignedResources, err := locations.FindMissingLocationResources(potentialResources, existingResources)
	if err != nil {
		return fmt.Errorf("issue finding new resources while updating a location quantities: %v\n", err)
	}

	// create new resources in the db.
	err = locations.CreateNewResources(locationId, unassignedResources)
	if err != nil {
		return fmt.Errorf("problem creating new resources while updating location res quantities: %v", err)
	}

	// combine existing, and unassigned resources
	existingResources = append(existingResources, unassignedResources...)

	// match base_rate of potentialResources to existingResources
	existingResources = locations.AddRatesToResourcesFromMapResourceNameRate(existingResources, potentialResources)

	// calculate the # of minutes passed from last_updated to time.Now(). Store in map of [resource]minutes
	mapResourceMin := locations.CalculateMinutesPassedFromLastUpdate(existingResources)

	// taking the resource, and corresponding minutes, adjust each resource to the new quantity
	existingResources = locations.CalculateEarnings(mapResourceMin)

	// update the database with this []resource
	err = locations.UpdateLocationResources(locationId, existingResources)
	if err != nil {
		return fmt.Errorf("error updating location_resources values: %v", err)
	}

	return nil
}

// UpdateAllLocationsResourcesQuantities updates all locations quantities. Run this on login.
func UpdateAllLocationsResourcesQuantities(userId int) error {
	userLocations, err := locations.GetListOfNodesLinkedToUser(userId)
	if err != nil {
		return fmt.Errorf("error to update all locations rq: %v", err)
	}
	for _, location := range userLocations {
		err = UpdateLocationResourcesQuantity(location.Id)
		if err != nil {
			return fmt.Errorf("error updating a locations resource: locationName: %s, error: %v\n", location.Name, err)
		}
	}
	return nil
}
