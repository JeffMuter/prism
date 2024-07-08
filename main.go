package main

import (
	"fmt"
	"prism/nodes"
	"prism/render"
	"prism/user"
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

	err = nodes.CreateNode(thisUser)
	if err != nil {
		fmt.Println(err)
	}
	render.PaintScreen()
}
