package controllers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/bikram-ghuku/CMS/backend/models"
)

var BodyInven struct {
	ItemName  string  `json:"item_name"`
	ItemQty   float64 `json:"item_qty"`
	ItemPrice float64 `json:"item_price"`
	ItemDesc  string  `json:"item_desc"`
}

var RespItem struct {
	ItemName  string  `json:"item_name"`
	ItemQty   float64 `json:"item_qty"`
	ItemPrice float64 `json:"item_price"`
	ItemDesc  string  `json:"item_desc"`
}

var updatedItem struct {
	ItemId    string  `json:"item_id"`
	ItemName  string  `json:"item_name"`
	ItemQty   float64 `json:"item_qty"`
	ItemPrice float64 `json:"item_price"`
	ItemDesc  string  `json:"item_desc"`
}

var bodyDec struct {
	ItemId string `json:"item_id"`
}

func AddProducts(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	if err := json.NewDecoder(req.Body).Decode(&BodyInven); err != nil {
		log.Println(err.Error())
		http.Error(res, "Bad Request", http.StatusBadRequest)
		return
	}

	queryStr := fmt.Sprintf(`INSERT INTO inventory(item_name, item_qty, item_price, item_desc) VALUES ('%s', %f, %f, '%s')`, BodyInven.ItemName, BodyInven.ItemQty, BodyInven.ItemPrice, BodyInven.ItemDesc)

	_, err := db.Exec(queryStr)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	res.WriteHeader(http.StatusOK)
	res.Header().Set("Content-Type", "text/plain")
	res.Write([]byte("Item Added Successfully"))
}

func GetProductByID(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	if err := json.NewDecoder(req.Body).Decode(&bodyDec); err != nil {
		log.Println(err.Error())
		http.Error(res, "Bad Request", http.StatusBadRequest)
		return
	}

	queryStr := `SELECT item_name, item_qty, item_price, item_desc FROM inventory WHERE item_id = $1`
	row := db.QueryRow(queryStr, bodyDec.ItemId)

	err := row.Scan(&RespItem.ItemName, &RespItem.ItemQty, &RespItem.ItemPrice, &RespItem.ItemDesc)
	if err == sql.ErrNoRows {
		http.Error(res, "Not Found", http.StatusNotFound)
		return
	} else if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	res.Header().Set("Content-Type", "application/json")
	json.NewEncoder(res).Encode(RespItem)
}

func GetAllProducts(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	queryStr := `SELECT item_id, item_name, item_qty, item_price, item_desc FROM inventory`
	rows, err := db.Query(queryStr)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	items := []models.Inventory{}

	for rows.Next() {
		item := models.Inventory{}
		if err := rows.Scan(&item.ItemID, &item.ItemName, &item.ItemQty, &item.ItemPrice, &item.ItemDesc); err != nil {
			log.Println(err.Error())
			http.Error(res, "Internal Server Error", http.StatusInternalServerError)
			return
		}
		items = append(items, item)
	}

	res.Header().Set("Content-Type", "application/json")
	json.NewEncoder(res).Encode(items)
}

func UpdateProduct(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	if err := json.NewDecoder(req.Body).Decode(&updatedItem); err != nil {
		log.Println(err.Error())
		http.Error(res, "Bad Request", http.StatusBadRequest)
		return
	}

	queryStr := fmt.Sprintf(`UPDATE inventory SET item_name = '%s', item_qty = %f, item_price = %f, item_desc = '%s' WHERE item_id = '%s'`, updatedItem.ItemName, updatedItem.ItemQty, updatedItem.ItemPrice, updatedItem.ItemDesc, updatedItem.ItemId)
	_, err := db.Exec(queryStr)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	res.WriteHeader(http.StatusOK)
	res.Header().Set("Content-Type", "text/plain")
	res.Write([]byte("Item Updated Successfully"))
}

func DeleteProduct(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	if err := json.NewDecoder(req.Body).Decode(&bodyDec); err != nil {
		log.Println(err.Error())
		http.Error(res, "Bad Request", http.StatusBadRequest)
		return
	}

	queryStr := `DELETE FROM inventory WHERE item_id = $1`

	_, err := db.Exec(queryStr, bodyDec.ItemId)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	res.WriteHeader(http.StatusOK)
	res.Header().Set("Content-Type", "text/plain")
	res.Write([]byte("Item Deleted Successfully"))
}