package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"net/url"
	"os"

	"github.com/bikram-ghuku/CMS/backend/controllers"
	"github.com/bikram-ghuku/CMS/backend/middleware"
	"github.com/joho/godotenv"
	"github.com/rs/cors"

	_ "github.com/lib/pq"
)

var (
	port string
)

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Println(err.Error())
	}

	frontend_url := os.Getenv("FRONTEND_URL")

	serviceURI := os.Getenv("DB_STRING")

	conn, _ := url.Parse(serviceURI)
	conn.RawQuery = "sslmode=verify-ca;sslrootcert=ca.pem"

	db, err := sql.Open("postgres", conn.String())

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

	// -----
	boqIdItemHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetInvUsedBoqId(w, r, db)
	})
	http.Handle("POST /inven/boqId", middleware.JWTMiddleware(boqIdItemHandler))
	log.Println("Loaded Route: POST /inven/boqId")

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
	reOpenCompHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.OpenComplaint(w, r, db)
	})
	http.Handle("POST /comp/open", middleware.JWTMiddleware(reOpenCompHandler))
	log.Println("Loaded Route: POST /comp/open")

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

	//------
	delCompHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.DelComp(w, r, db)
	})
	http.Handle("POST /comp/delete", middleware.JWTMiddleware(delCompHandler))
	log.Println("Loaded Route: POST /comp/delete")

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

	//------
	invPdtHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetUseByPdtId(w, r, db)
	})
	http.Handle("POST /inven/usepdtid", middleware.JWTMiddleware(invPdtHandler))
	log.Println("Loaded Route: POST /inven/usepdtid")

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

	//
	//
	// Chart Route

	chartHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetCompChart(w, r, db)
	})
	http.Handle("GET /stat/chart", middleware.JWTMiddleware(chartHandler))
	log.Println("Loaded Route: GET /stat/chart")

	//
	//
	// Bill Routes

	// Make bill
	billMakeHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.MakeBill(w, r, db)
	})
	http.Handle("POST /bill/make", middleware.JWTMiddleware(billMakeHandler))
	log.Println("Loaded Route: POST /bill/make")

	// Get all Bills
	allBillGetHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetAllBills(w, r, db)
	})
	http.Handle("GET /bill/all", middleware.JWTMiddleware(allBillGetHandler))
	log.Println("Loaded Route: GET /bill/all")

	// Get Bill by id
	billGetHandler := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetBill(w, r, db)
	})
	http.Handle("POST /bill/get", middleware.JWTMiddleware(billGetHandler))
	log.Println("Loaded Route: POST /bill/get")

	billItemsAbstract := http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		controllers.GetBillJoinInven(w, r, db)
	})
	http.Handle("POST /bill/getItems", middleware.JWTMiddleware(billItemsAbstract))
	log.Println("Loaded Route: POST /bill/getItems")

	c := cors.New(cors.Options{
		AllowedOrigins:   []string{frontend_url},
		AllowCredentials: true,
	})

	log.Printf("Listening for conn on %s", frontend_url)
	handler := c.Handler(http.DefaultServeMux)

	port = os.Getenv("PORT")
	log.Printf("Listening on port: %s", port)
	if err := http.ListenAndServe(fmt.Sprintf("0.0.0.0:%s", port), handler); err != nil {
		log.Panicln(err.Error())
	}
}
