package main

import (
	"fmt"
	"prism/locations"
	"prism/menus"
	"prism/render"
	"prism/user"
	"prism/workers"
)

func main() {

	var thisUser = user.User{
		Id:       1,
		Username: "1",
		Email:    "1@gmail.com",
		Password: "1",
		//set lat & long
	}

	var err error

	thisUser.Latitude, thisUser.Longitude, err = user.Ping()
	if err != nil {
		fmt.Println(err)
	}
	//locations, _ := locations.GetListOfNodesLinkedToUser(thisUser.Id)

	err = locations.UpdateAllLocationsResourcesQuantities(thisUser.Id)
	if err != nil {
		err = fmt.Errorf("login issue: updating all user's locations quantities: %v", err)
		fmt.Println(err)
	}

	workers.GetWorkersRelevantToUser(thisUser)

	render.PaintScreen(thisUser)

	menus.MainMenuListen(thisUser)
}
