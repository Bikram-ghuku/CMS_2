package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"

	"github.com/bikram-ghuku/CMS/backend/controllers"
	"github.com/joho/godotenv"

	_ "github.com/lib/pq"
)

var (
	db_port  int
	db_host  string
	db_uname string
	db_pass  string
	db_name  string
	db       *sql.DB
	port     string
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
		log.Panic(err.Error())
	}

	port = os.Getenv("PORT")
	psqlconn := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=disable", db_host, db_port, db_uname, db_pass, db_name)

	db, err = sql.Open("postgres", psqlconn)
	if err != nil {
		log.Panic(err.Error())
	}

	err = db.Ping()
	if err != nil {
		log.Panic(err.Error())
	}

	// User Routes
	http.HandleFunc("POST /user/login", func(w http.ResponseWriter, r *http.Request) {
		controllers.Login(w, r, db)
	})

	http.HandleFunc("POST /user/register", func(w http.ResponseWriter, r *http.Request) {
		controllers.Register(w, r, db)
	})

	http.HandleFunc("GET /user/all", func(w http.ResponseWriter, r *http.Request) {
		controllers.GetAllUser(w, r, db)
	})

	// Inventory Routes
	http.HandleFunc("POST /inven/addItem", func(w http.ResponseWriter, r *http.Request) {
		controllers.AddProducts(w, r, db)
	})

	http.HandleFunc("GET /inven/all", func(w http.ResponseWriter, r *http.Request) {
		controllers.GetAllProducts(w, r, db)
	})

	http.HandleFunc("GET /inven/allId", func(w http.ResponseWriter, r *http.Request) {
		controllers.GetProductByID(w, r, db)
	})

	http.HandleFunc("POST /inven/invUpdate", func(w http.ResponseWriter, r *http.Request) {
		controllers.UpdateProduct(w, r, db)
	})

	http.HandleFunc("POST /inven/delinv", func(w http.ResponseWriter, r *http.Request) {
		controllers.DeleteProduct(w, r, db)
	})

	//Complaints Routes
	http.HandleFunc("POST /comp/add", func(w http.ResponseWriter, r *http.Request) {
		controllers.AddComplaint(w, r, db)
	})

	http.HandleFunc("POST /comp/close", func(w http.ResponseWriter, r *http.Request) {
		controllers.CloseComplaint(w, r, db)
	})

	http.HandleFunc("GET /comp/all", func(w http.ResponseWriter, r *http.Request) {
		controllers.GetAllComp(w, r, db)
	})

	http.HandleFunc("POST /comp/update", func(w http.ResponseWriter, r *http.Request) {
		controllers.UpdateComp(w, r, db)
	})

	log.Printf("Listening on port: %s", port)
	if err := http.ListenAndServe(fmt.Sprintf("0.0.0.0:%s", port), http.DefaultServeMux); err != nil {
		log.Panicln(err.Error())
	}
}
