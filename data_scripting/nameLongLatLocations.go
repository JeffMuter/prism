package data_scripting

import (
	"bufio"
	"fmt"
	_ "github.com/lib/pq"
	"log"
	"os"
	"prism/database"
	"strconv"
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
		var loctype string = "city"
		var description string = "a large city in the distance... probably"
		var art = "city_art"

		var name = nameLocationSlice[0]
		var lat float64
		var long float64
		lat, err = strconv.ParseFloat(nameLocationSlice[1], 64)
		if err != nil {
			fmt.Println("error converting lat to float:", err)
		}
		long, err = strconv.ParseFloat(nameLocationSlice[2], 64)
		if err != nil {
			fmt.Println("error converting lat to float:", err)
		}

		query := `INSERT INTO locations (default_accessible, location_type, longitude, latitude, name, description, art) VALUES ($1, $2, $3, $4, $5, $6, $7 )`
		_, err := db.Exec(query, true, loctype, long, lat, name, description, art)
		if err != nil {
			log.Panic("executing to db...", err)
		}
		fmt.Printf("name: %s, lat: %v, long: %v\n", name, lat, long)
	}
}
