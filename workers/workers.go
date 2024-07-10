package workers

import (
	"prism/database"
	"prism/user"
	"time"
)

type Worker struct {
	id         int
	userId     int
	workStatus bool
	createdAt  time.Time
	name       string
	art        string `default:"@"`
}

func CreateWorker() {

}

func GetWorkersRelevantToUser(user user.User) []Worker {
	var workers []Worker

	db := database.OpenDatabase()
	defer db.Close()

	//query := "SELECT name"

	//rows, err := db.Query(query, user.Id)
	//if err != nil {
	//
	//}

	return workers
}
