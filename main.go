package main

import (
	"bufio"
	"fmt"
	"os"
	"prism/render"
	"prism/user"
	"strings"
)

func main() {
	var thisUser = user.User{
		Id:       1,
		Username: "1",
		Email:    "1@gmail.com",
		Password: "1",
	}

	canvas := render.PaintScreen()

	for _, line := range canvas {
		fmt.Println(string(line))
	}

	reader := bufio.NewReader(os.Stdin)

	input, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("Invalid input: ", err)
	}
	input = strings.TrimSpace(input)

	if input == "ping" {
		user.Ping()
	}
}
