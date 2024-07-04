package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"

	"github.com/joho/godotenv"
)

var (
	db_port  int
	db_host  string
	db_uname string
	db_pass  string
	db_name  string
	db       *sql.DB
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Println(err.Error())
	}

	db_host = os.Getenv("DB_HOST")
	db_uname = os.Getenv("DB_UNAME")
	db_pass = os.Getenv("DB_PSWD")
	db_name = os.Getenv("DB_NAME")

	db_port, err = strconv.Atoi(os.Getenv("DB_PORT"))
	if err != nil {
		log.Println(err.Error())
	}

	psqlconn := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable", db_host, db_port, db_uname, db_pass, db_name)

	db, err = sql.Open("postgres", psqlconn)
	if err != nil {
		log.Println(err.Error())
	}

	err = db.Ping()
	if err != nil {
		log.Println(err.Error())
	}

	log.Println("Listening on port: 8000")
	if err := http.ListenAndServe("0.0.0.0:8000", http.DefaultServeMux); err != nil {
		log.Panicln(err.Error())
	}
}
