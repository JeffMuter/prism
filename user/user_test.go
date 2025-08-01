package user

import "testing"

func TestPing(t *testing.T) {
	lat, long, err := Ping()
	if err != nil {
		t.Errorf("ping test came back err: %v. Lat&Long: %v,%v\n", err, lat, long)
	}
}

func TestGetUser(t *testing.T) {
	email := "1@gmail.com"
	user, err := GetUser(email)
	if err != nil {
		t.Errorf("get user ret error: %v, email used was: %s\n", err, email)
	}

	switch {
	case user.Id == 0:
		t.Errorf("user id is 0")
	case user.Email == "":
		t.Errorf("user email empty")
	case user.Email != email:
		t.Errorf("user email does not match email used to query. user.Email: %s, email for testing: %s\n", user.Email, email)
	case user.Password == "":
		t.Errorf("user password empty")
	}
}
