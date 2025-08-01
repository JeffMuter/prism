// package db
//
// import (
// 	"bufio"
// 	"fmt"
// 	"log"
// 	"os"
// 	"prism/db"
// 	"strconv"
// 	"strings"
// )
//
// // intend to take a txt file, parse each line's name, long, and lat, then convert to inserting each
// // line into the s locations
//
// func SqliteAddCities() {
// 	err := db.OpenDatabase()
// 	if err != nil {
// 		fmt.Println("error opening db")
// 	}
//
// 	db := db.GetDB()
//
// 	file, err := os.Open("data_scripting/city.txt")
// 	if err != nil {
// 		fmt.Println("file link likely broken")
// 	}
// 	defer file.Close()
//
// 	scanner := bufio.NewScanner(file)
//
// 	for scanner.Scan() {
// 		nameLocationSlice := strings.Split(scanner.Text(), "	")
//
// 		var loctypeId int = 8
// 		var description string = "a large city in the distance... probably"
// 		var art = "city_art"
// 		var lat float64
// 		var long float64
//
// 		var name = nameLocationSlice[0]
//
// 		lat, err = strconv.ParseFloat(nameLocationSlice[1], 64)
// 		if err != nil {
// 			fmt.Println("error converting lat to float:", err)
// 		}
// 		long, err = strconv.ParseFloat(nameLocationSlice[2], 64)
// 		if err != nil {
// 			fmt.Println("error converting lat to float:", err)
// 		}
//
// 		query := `INSERT INTO locations (default_accessible,location_type_id, longitude, latitude, name, description, art) VALUES ($1, $2, $3, $4, $5, $6, $7)`
// 		_, err := db.Exec(query, true, loctypeId, long, lat, name, description, art)
// 		if err != nil {
// 			log.Panic("executing to ..", err)
// 		}
// 		fmt.Printf("name: %s, lat: %v, long: %v\n", name, lat, long)
// 	}
// }
