package controllers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

var InvenBody struct {
	UserId  string  `json:"user_id"`
	CompId  string  `json:"comp_id"`
	ItemId  string  `json:"item_id"`
	ItemQty float64 `json:"item_qty"`
}

var CurrQty struct {
	Qty float64 `db:"item_qty"`
}

func InvenToComp(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	if err := json.NewDecoder(req.Body).Decode(&InvenBody); err != nil {
		log.Println(err.Error())
		http.Error(res, "Bad Request", http.StatusBadRequest)
		return
	}

	currQtyQuery := fmt.Sprintf("SELECT item_qty FROM inventory WHERE item_id='%s'", InvenBody.ItemId)
	row := db.QueryRow(currQtyQuery)
	row.Scan(&CurrQty.Qty)

	if CurrQty.Qty < InvenBody.ItemQty {
		log.Println("Accessing more items than present in Inventory")
		http.Error(res, "Items Not Present", http.StatusConflict)
		return
	}

	query := fmt.Sprintf("INSERT INTO inven_used(user_id, comp_id, item_id, item_used) VALUES ('%s', '%s', '%s', %f)", InvenBody.UserId, InvenBody.CompId, InvenBody.ItemId, InvenBody.ItemQty)

	_, err := db.Exec(query)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	remainItem := CurrQty.Qty - InvenBody.ItemQty
	queryUpdateQty := fmt.Sprintf("UPDATE inventory SET item_qty = %f WHERE item_id = '%s'", remainItem, InvenBody.ItemId)

	_, err = db.Exec(queryUpdateQty)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	res.WriteHeader(http.StatusOK)
	res.Header().Set("Content-Type", "text/plain")
	res.Write([]byte("Item added to Complaint"))
}
