package menus

import (
	"bufio"
	"fmt"
	"os"
	"prism/nodes"
	"prism/user"
	"strconv"
	"strings"
)

func DisplayUserNodes(user user.User) {
	// get a list of locations
	var locations []nodes.Location = nodes.GetListOfNodesLinkedToUser(user)
	// display info on each node.
	for i := range locations {
		fmt.Printf("%v | name: %v | direction: %v | location: %v | \n", i)
	}
	// listen for intput
	nodeMenuListen(len(locations))
}

func nodeMenuListen(locations []nodes.Location) {

	reader := bufio.NewReader(os.Stdin)

	input, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("Invalid input: ", err)
	}
	input = strings.TrimSpace(input)

	if intInput, err := strconv.Atoi(input); err == nil && intInput < len(locations) {
		fmt.Printf("Name: %s| WorkerCount: %s | type: %s| Longitude: %v | Latitude: %v\n", locations[intInput].Name, locations[intInput].LocationType, locations[intInput].Longitude, locations[intInput].Latitude)
	}
}
