package controllers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/bikram-ghuku/CMS/backend/models"
)

var CompBody struct {
	CompNos  string    `json:"comp_nos"`
	CompLoc  string    `json:"comp_loc"`
	CompDes  string    `json:"comp_des"`
	CompDate time.Time `json:"comp_date"`
}

var CloseCompBody struct {
	CompNos string    `json:"comp_nos"`
	CompId  string    `json:"comp_id"`
	FinText string    `json:"fin_text"`
	FinTime time.Time `json:"fin_datetime"`
}

var UpdtCompBody struct {
	CompId   string    `json:"comp_id"`
	CompNos  string    `json:"comp_nos"`
	CompLoc  string    `json:"comp_loc"`
	CompDes  string    `json:"comp_des"`
	CompDate time.Time `json:"comp_date"`
}

func AddComplaint(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	if err := json.NewDecoder(req.Body).Decode(&CompBody); err != nil {
		log.Println(err.Error())
		http.Error(res, "Bad Request", http.StatusBadRequest)
		return
	}

	log.Println(CompBody.CompDate)
	query := fmt.Sprintf("INSERT INTO complaints(comp_nos, comp_loc, comp_des, comp_date, comp_stat) VALUES('%s', '%s', '%s', '%s', '%s')", CompBody.CompNos, CompBody.CompLoc, CompBody.CompDes, CompBody.CompDate.Format(time.RFC3339Nano), models.CompOpen)

	_, err := db.Exec(query)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	res.WriteHeader(http.StatusOK)
	res.Header().Set("Content-Type", "text/plain")
	res.Write([]byte("Complaint Added Successfully"))
}

func CloseComplaint(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	if err := json.NewDecoder(req.Body).Decode(&CloseCompBody); err != nil {
		log.Println(err.Error())
		http.Error(res, "Bad Request", http.StatusBadRequest)
		return
	}

	query := fmt.Sprintf("UPDATE complaints SET fin_text = '%s', fin_datetime = '%s', comp_stat = '%s' WHERE comp_nos = '%s' AND comp_id = '%s'", CloseCompBody.FinText, CloseCompBody.FinTime.Format(time.RFC3339Nano), models.CompClose, CloseCompBody.CompNos, CloseCompBody.CompId)

	_, err := db.Exec(query)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	res.WriteHeader(http.StatusOK)
	res.Header().Set("Content-Type", "text/plain")
	res.Write([]byte("Compaint Closed Succesfully"))
}

func OpenComplaint(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	if err := json.NewDecoder(req.Body).Decode(&CloseCompBody); err != nil {
		log.Println(err.Error())
		http.Error(res, "Bad Request", http.StatusBadRequest)
		return
	}

	query := fmt.Sprintf("UPDATE complaints SET fin_text = '', fin_datetime = '%s', comp_stat = '%s' WHERE comp_nos = '%s' AND comp_id = '%s'", CloseCompBody.FinTime.Format(time.RFC3339Nano), models.CompOpen, CloseCompBody.CompNos, CloseCompBody.CompId)

	_, err := db.Exec(query)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	res.WriteHeader(http.StatusOK)
	res.Header().Set("Content-Type", "text/plain")
	res.Write([]byte("Compaint ReOpend Succesfully"))
}

func GetAllComp(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	queryStr := "SELECT * FROM complaints ORDER BY comp_date ASC"
	rows, err := db.Query(queryStr)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	complaints := []models.Complaint{}

	for rows.Next() {
		complaint := models.Complaint{}
		if err := rows.Scan(&complaint.CompID, &complaint.CompNos, &complaint.CompLoc, &complaint.CompDes, &complaint.CompStat, &complaint.CompDate, &complaint.FinDatetime, &complaint.FinText); err != nil {
			log.Println(err.Error())
			http.Error(res, "Internal Server Error", http.StatusInternalServerError)
			return
		}

		complaints = append(complaints, complaint)
	}

	res.Header().Set("Content-Type", "application/json")
	json.NewEncoder(res).Encode(complaints)
}

func UpdateComp(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	if err := json.NewDecoder(req.Body).Decode(&UpdtCompBody); err != nil {
		log.Println(err.Error())
		http.Error(res, "Bad Request", http.StatusBadRequest)
		return
	}

	query := fmt.Sprintf("UPDATE complaints SET comp_nos = '%s', comp_loc = '%s', comp_des = '%s', comp_date = '%s' WHERE comp_id = '%s'", UpdtCompBody.CompNos, UpdtCompBody.CompLoc, UpdtCompBody.CompDes, UpdtCompBody.CompDate.Format(time.RFC3339Nano), UpdtCompBody.CompId)

	_, err := db.Exec(query)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	res.WriteHeader(http.StatusOK)
	res.Header().Set("Content-Type", "text/plain")
	res.Write([]byte("Complaint Updated Successfully"))
}
