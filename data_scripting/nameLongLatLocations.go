package data_scripting

import (
	"bufio"
	"fmt"
	_ "github.com/lib/pq"
	"os"
	"prism/database"
	"strings"
)

// intend to take a txt file, parse each line's name, long, and lat, then convert to inserting each
// line into the db's locations

func AddLocationsToDb() {
	db := database.OpenDatabase()
	defer db.Close()

	file, err := os.Open("data_scripting/city.txt")
	if err != nil {
		fmt.Println("file link likely broken")
	}

	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		nameLocationSlice := strings.Split(scanner.Text(), "	")
		for output := range nameLocationSlice {
			fmt.Println(output)
		}
	}
}
