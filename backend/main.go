package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"

	"github.com/bikram-ghuku/CMS/backend/controllers"
	"github.com/bikram-ghuku/CMS/backend/middleware"
	"github.com/joho/godotenv"
	"github.com/rs/cors"

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
	frontend_url := os.Getenv("FRONTEND_URL")

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

	//
	//
	// User Routes
	http.HandleFunc("POST /user/login", func(w http.ResponseWriter, r *http.Request) {
		controllers.Login(w, r, db)
	})
	log.Println("Loaded Route: POST /user/login")

	//----
	registerHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.Register(w, r, db)
	})
	http.Handle("POST /user/register", middleware.JWTMiddleware(registerHandler))
	log.Println("Loaded Route: POST /user/register")

	//----
	allUserHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetAllUser(w, r, db)
	})
	http.Handle("GET /user/all", middleware.JWTMiddleware(allUserHandler))
	log.Println("Loaded Route: GET /user/all")

	// ------
	regRoleUser := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.RegisterByRole(w, r, db)
	})
	http.Handle("POST /user/rolereg", middleware.JWTMiddleware(regRoleUser))
	log.Println("Loaded Route: POST /user/rolereg")

	rstPswdHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.ResetPswd(w, r, db)
	})
	http.Handle("POST /user/chngpswd", middleware.JWTMiddleware(rstPswdHandler))
	log.Println("Loaded Route: POST /user/chngpswd")

	//
	//
	// Inventory Routes
	addItemHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.AddProducts(w, r, db)
	})
	http.Handle("POST /inven/addItem", middleware.JWTMiddleware(addItemHandler))
	log.Println("Loaded Route: POST /inven/addItem")

	// -----
	allItemHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetAllProducts(w, r, db)
	})
	http.Handle("GET /inven/all", middleware.JWTMiddleware(allItemHandler))
	log.Println("Loaded Route: GET /inven/all")

	// -----
	allIdItemHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetProductByID(w, r, db)
	})
	http.Handle("GET /inven/allId", middleware.JWTMiddleware(allIdItemHandler))
	log.Println("Loaded Route: GET /inven/allId")

	//-----
	updateItemHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.UpdateProduct(w, r, db)
	})
	http.Handle("POST /inven/invUpdate", middleware.JWTMiddleware(updateItemHandler))
	log.Println("Loaded Route: POST /inven/invUpdate")

	//-----
	delItemHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.DeleteProduct(w, r, db)
	})
	http.Handle("POST /inven/delinv", middleware.JWTMiddleware(delItemHandler))
	log.Println("Loaded Route: POST /inven/delinv")

	//
	//
	//Complaints Routes
	addCompHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.AddComplaint(w, r, db)
	})
	http.Handle("POST /comp/add", middleware.JWTMiddleware(addCompHandler))
	log.Println("Loaded Route: POST /comp/add")

	//-----
	closeCompHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.CloseComplaint(w, r, db)
	})
	http.Handle("POST /comp/close", middleware.JWTMiddleware(closeCompHandler))
	log.Println("Loaded Route: POST /comp/close")

	//------
	allCompHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetAllComp(w, r, db)
	})
	http.Handle("GET /comp/all", middleware.JWTMiddleware(allCompHandler))
	log.Println("Loaded Route: GET /comp/all")

	//-------
	updtCompHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.UpdateComp(w, r, db)
	})
	http.Handle("POST /comp/update", middleware.JWTMiddleware(updtCompHandler))
	log.Println("Loaded Route: POST /comp/update")

	//
	//
	// Inventory Used
	invUseHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.InvenToComp(w, r, db)
	})
	http.Handle("POST /inven/use", middleware.JWTMiddleware(invUseHandler))
	log.Println("Loaded Route: POST /inven/use")

	//------
	getInvUseHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetInvUsed(w, r, db)
	})
	http.Handle("GET /inven/useall", middleware.JWTMiddleware(getInvUseHandler))
	log.Println("Loaded Route: GET /inven/useall")

	//----
	invCompHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetInvUsedCompId(w, r, db)
	})
	http.Handle("POST /inven/usecomp", middleware.JWTMiddleware(invCompHandler))
	log.Println("Loaded Route: POST /inven/usecomp")

	// -----
	invUseDelHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.DelInvenUsed(w, r, db)
	})
	http.Handle("POST /inven/deluse", middleware.JWTMiddleware(invUseDelHandler))
	log.Println("Loaded Route: POST /inven/deluse")

	// ----
	invUpdtHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.UpdtInvenUse(w, r, db)
	})
	http.Handle("POST /inven/updtuse", middleware.JWTMiddleware(invUpdtHandler))
	log.Println("Loaded Route: POST /inven/updtuse")

	//
	//
	// Data Routes
	numHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetNumData(w, r, db)
	})
	http.Handle("GET /stat/num", middleware.JWTMiddleware(numHandler))
	log.Println("Loaded Route: GET /stat/num")

	c := cors.New(cors.Options{
		AllowedOrigins:   []string{frontend_url},
		AllowCredentials: true,
	})
	log.Printf("Listening for conn on %s", frontend_url)
	handler := c.Handler(http.DefaultServeMux)
	log.Printf("Listening on port: %s", port)
	if err := http.ListenAndServe(fmt.Sprintf("0.0.0.0:%s", port), handler); err != nil {
		log.Panicln(err.Error())
	}
}
