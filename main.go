package main

import (
	"fmt"
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

	workers.GetWorkersRelevantToUser(thisUser)

	render.PaintScreen(thisUser)

	menus.MainMenuListen(thisUser)
}
