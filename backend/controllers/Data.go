package controllers

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"
)

var resData struct {
	Inventory        float64 `json:"inven_nos"`
	Complaints_open  float64 `json:"comp_open_nos"`
	Complaints_close float64 `json:"comp_close_nos"`
	Users            float64 `json:"user_nos"`
}

func GetNumData(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	queryUser := "SELECT COUNT(*) FROM users"
	queryInven := "SELECT COUNT(*) FROM inventory"
	queryCompOpen := "SELECT COUNT(*) FROM complaints WHERE comp_stat='open'"
	queryCompClose := "SELECT COUNT(*) FROM complaints WHERE comp_stat='closed'"

	row := db.QueryRow(queryUser)
	row.Scan(&resData.Users)

	row = db.QueryRow(queryInven)
	row.Scan(&resData.Inventory)

	row = db.QueryRow(queryCompOpen)
	row.Scan(&resData.Complaints_open)

	row = db.QueryRow(queryCompClose)
	row.Scan(&resData.Complaints_close)

	http.Header.Add(res.Header(), "content-type", "application/json")

	if err := json.NewEncoder(res).Encode(&resData); err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}
}
