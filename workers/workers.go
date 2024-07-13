package workers

import (
	"fmt"
	"prism/database"
	"prism/nodes"
	"prism/user"
	"time"
)

type Worker struct {
	id             int
	userLocationId int
	userId         int
	locationId     int
	workStatus     bool
	injuredStatus  bool
	strength       int
	faith          int
	intelligence   int
	createdAt      time.Time
	religion       string
	name           string
	artFilName     string `default:"worker"`
	art            nodes.Art
}

func CreateWorker() {

}

func GetWorkersRelevantToUser(user user.User) []Worker {
	var workers []Worker

	db := database.OpenDatabase()
	defer db.Close()

	query := "SELECT name FROM workers LEFT JOIN user_locations ON workers.user_locations_id = user_locations.id WHERE user_id = $1"

	rows, err := db.Query(query, user.Id)
	if err != nil {
		fmt.Println("error querying: ", err)
	}
	for rows.Next() {
		var worker Worker
		rows.Scan(&worker.name)
		workers = append(workers, worker)
	}

	return workers
}
