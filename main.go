package main

import (
	"fmt"
	"prism/logic"
	"prism/menus"
	"prism/render"
	"prism/user"
)

func main() {

	var thisUser = user.User{
		Id:       1,
		Username: "1",
		Email:    "1@gmail.com",
		Password: "1",
	}

	var err error

	thisUser.Latitude, thisUser.Longitude, err = user.Ping()
	if err != nil {
		fmt.Println(err)
	}

	err = logic.UpdateAllLocationsResourcesQuantities(thisUser.Id)
	if err != nil {
		err = fmt.Errorf("error updating all user's locations quantities: %v", err)
		fmt.Println(err)
	}

	render.PaintScreen(thisUser)

	err = menus.MainMenuListen(thisUser)
	if err != nil {
		fmt.Println(fmt.Errorf("problem in main menu: %v", err))
	} else {
		fmt.Println("Main menu closed...")
	}
}
