package controllers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"
)

var BillId string

var BillBody struct {
	BillId string `json:"bill_id"`
}

var BillDateTime time.Time

type NewInvenItem struct {
	ItemID    string  `json:"item_id"`
	ItemDesc  string  `json:"item_desc"`
	ItemUnit  string  `json:"item_unit"`
	ItemUsed  float64 `json:"item_used"`
	ItemPrice float64 `json:"item_price"`
	UptoUse   float64 `json:"upto_use"`
	UptoAmt   float64 `json:"upto_amt"`
}

type RetBill struct {
	Id       string `json:"bill_id"`
	DateTime string `json:"bill_dt"`
}

var MakeBody struct {
	MakeName string `json:"work_name"`
}

func MakeBill(res http.ResponseWriter, req *http.Request, db *sql.DB) {

	if err := json.NewDecoder(req.Body).Decode((&MakeBody)); err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	currentTime := time.Now()
	var id string
	query := fmt.Sprintf("INSERT INTO bills(dateTime, workName) VALUES('%s', '%s') RETURNING id", currentTime.Format(time.RFC3339Nano), MakeBody.MakeName)
	rows, err := db.Query(query)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	for rows.Next() {
		rows.Scan(&id)
	}
	query = fmt.Sprintf("UPDATE inven_used SET bill_id = '%s' WHERE bill_id IS NULL", id)

	if _, err = db.Exec(query); err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	res.WriteHeader(http.StatusOK)
	res.Header().Set("Content-Type", "text/plain")
	res.Write([]byte("New Bill Generated"))

}

func GetAllBills(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	query := "SELECT * FROM bills"
	rows, err := db.Query(query)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	var billRes []RetBill
	for rows.Next() {
		var billItem RetBill

		err := rows.Scan(&billItem.Id, &billItem.DateTime)
		if err != nil {
			log.Println(err.Error())
			http.Error(res, "Internal Server Error", http.StatusInternalServerError)
			return
		}

		billRes = append(billRes, billItem)
	}

	res.Header().Set("Content-Type", "application/json")
	err = json.NewEncoder(res).Encode(billRes)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}
}

func GetBill(res http.ResponseWriter, req *http.Request, db *sql.DB) {

	if err := json.NewDecoder(req.Body).Decode(&BillBody); err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	query := fmt.Sprintf("SELECT dateTime FROM bills WHERE id = '%s'", BillBody.BillId)
	row := db.QueryRow(query)

	row.Scan(&BillDateTime)

	query = fmt.Sprintf(`SELECT 
		i.item_id,
		i.item_desc,
		i.item_unit,
		COALESCE(iu.item_used, 0) AS item_used,
		i.item_price
	FROM 
		inventory i
	LEFT JOIN 
		inven_used iu ON iu.item_id = i.item_id 
	AND 
		iu.bill_id = '%s';`, BillBody.BillId)

	rows, err := db.Query(query)
	if err != nil {
		log.Println("Error executing query:", err)
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var invenUsedList []NewInvenItem

	for rows.Next() {
		var invenUsed NewInvenItem
		err := rows.Scan(
			&invenUsed.ItemID,
			&invenUsed.ItemDesc,
			&invenUsed.ItemUnit,
			&invenUsed.ItemUsed,
			&invenUsed.ItemPrice,
		)
		if err != nil {
			log.Println("Error scanning rows:", err)
			http.Error(res, "Internal Server Error", http.StatusInternalServerError)
			return
		}

		query = fmt.Sprintf(`SELECT 
			COALESCE(SUM(iu.item_used), 0), 
			COALESCE(SUM(iu.item_used * i.item_price), 0) 
		FROM 
			inven_used iu
		JOIN
			inventory i ON i.item_id = iu.item_id
		JOIN
			bills b ON b.id = iu.bill_id
		WHERE
			b.dateTime < '%s' AND i.item_id = '%s'`, BillDateTime.Format(time.RFC3339Nano), invenUsed.ItemID)

		row = db.QueryRow(query)
		err = row.Scan(&invenUsed.UptoUse, &invenUsed.UptoAmt)
		if err != nil {
			log.Println("Error scanning rows:", err)
			http.Error(res, "Internal Server Error", http.StatusInternalServerError)
			return
		}
		invenUsedList = append(invenUsedList, invenUsed)
	}

	res.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(res).Encode(invenUsedList); err != nil {
		log.Println("Error encoding JSON:", err)
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}
}
