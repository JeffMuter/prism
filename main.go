package main

import "prism/data_scripting"

func main() {

	data_scripting.AddLocationsToDb()

	//var thisUser = user.User{
	//	Id:       1,
	//	Username: "1",
	//	Email:    "1@gmail.com",
	//	Password: "1",
	//}

	//canvas := render.PaintScreen()
	//
	//for _, line := range canvas {
	//	fmt.Println(string(line))
	//}
	//
	//reader := bufio.NewReader(os.Stdin)
	//
	//input, err := reader.ReadString('\n')
	//if err != nil {
	//	fmt.Println("Invalid input: ", err)
	//}
	//input = strings.TrimSpace(input)
	//
	//if input == "ping" {
	//	lat, long, err := user.Ping()
	//	if err != nil {
	//		fmt.Println("ping err: ", err)
	//	}
	//	fmt.Printf("lat: %v, long: %v.\n", lat, long)
	//} else if input == "node" {
	//	userLat, userLong, err := user.Ping()
	//	if err != nil {
	//		fmt.Println(err)
	//	}
	//	err = nodes.CreateNode(1, userLat, userLong)
	//	if err != nil {
	//		fmt.Println(err)
	//	}
	//}
}
