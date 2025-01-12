package database

import (
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"
)

const (
	host     = "/var/run/postgresql" // Unix socket directory
	port     = 5432
	user     = "emerald"
	password = "postgres1"
	dbname   = "prism"
)

var db *sql.DB

func OpenDatabase() error {
	var err error
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+
		"password=%s dbname=%s sslmode=disable",
		host, port, user, password, dbname)

	db, err = sql.Open("postgres", psqlInfo)
	if err != nil {
		return fmt.Errorf("error unable to connect to db... %w,", err)

	}

	err = db.Ping()
	if err != nil {
		fmt.Println("unable to ping db...", err)
		return fmt.Errorf("error pinging db: %w", err)
	}
	return nil
}

func GetDB() *sql.DB {
	return db
}
