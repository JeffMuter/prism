package database

import (
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"
)

const (
	host     = "localhost"
	port     = 5432
	user     = "postgres"
	password = "postgres1"
	dbname   = "prism"
)

var db *sql.DB

func OpenDatabase() {
	var err error
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+
		"password=%s dbname=%s sslmode=disable",
		host, port, user, password, dbname)

	db, err = sql.Open("postgres", psqlInfo)
	if err != nil {
		fmt.Println("unable to connect to db...", err)
	}

	err = db.Ping()
	if err != nil {
		fmt.Println("unable to ping db...", err)
	}
}

func GetDB() *sql.DB {
	return db
}
