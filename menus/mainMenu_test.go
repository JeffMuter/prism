package menus

import (
	"prism/user"
	"testing"
)

func TestMainMenuListen(t *testing.T) {
	var testUser user.User
	err := MainMenuListen(testUser)
	if err == nil {
		t.Error("blank user not returning err")
	}
	thisUser := user.User{
		Id:       1,
		Username: "1",
		Email:    "1@gmail.com",
		Password: "1",
	}
	err = MainMenuListen(thisUser)
	if err != nil {
		t.Error("something went wrong")
	}
}
