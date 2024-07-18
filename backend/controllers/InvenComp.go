package controllers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/bikram-ghuku/CMS/backend/middleware"
)

var InvenBody struct {
	CompId  string  `json:"comp_id"`
	ItemId  string  `json:"item_id"`
	ItemQty float64 `json:"item_qty"`
}

var CurrQty struct {
	Qty float64 `db:"item_qty"`
}

var CompIdBody struct {
	CompId string `json:"comp_id"`
}

type InvenUsed struct {
	ID        string  `json:"id"`
	ItemUsed  float64 `json:"item_used"`
	UserID    string  `json:"user_id"`
	Username  string  `json:"username"`
	Role      string  `json:"role"`
	ItemID    string  `json:"item_id"`
	ItemName  string  `json:"item_name"`
	ItemQty   float64 `json:"item_qty"`
	ItemPrice float64 `json:"item_price"`
	ItemDesc  string  `json:"item_desc"`
	ItemUnit  string  `json:"item_unit"`
	CompID    string  `json:"comp_id"`
	CompNos   string  `json:"comp_nos"`
	CompLoc   string  `json:"comp_loc"`
	CompDes   string  `json:"comp_des"`
	CompStat  string  `json:"comp_stat"`
	CompDate  string  `json:"comp_date"`
}

var delInvenUse struct {
	ID string `json:"id"`
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

	claims := middleware.GetClaims(req)
	query := fmt.Sprintf("INSERT INTO inven_used(user_id, comp_id, item_id, item_used) VALUES ('%s', '%s', '%s', %f)", claims.User_id, InvenBody.CompId, InvenBody.ItemId, InvenBody.ItemQty)

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

func GetInvUsed(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	claims := middleware.GetClaims(req)
	if claims.Role != "admin" {
		http.Error(res, "User Unauthorized", http.StatusUnauthorized)
		return
	}

	query := `
    SELECT 
        iu.id,
        iu.item_used,
        u.user_id,
        u.username,
        u.role,
        i.item_id,
        i.item_name,
        i.item_qty,
        i.item_price,
        i.item_desc,
		i.item_unit,
        c.comp_id,
        c.comp_nos,
        c.comp_loc,
        c.comp_des,
        c.comp_stat,
        c.comp_date
    FROM 
        inven_used iu
    JOIN 
        users u ON iu.user_id = u.user_id
    JOIN 
        inventory i ON iu.item_id = i.item_id
    JOIN 
        complaints c ON iu.comp_id = c.comp_id;
    `

	rows, err := db.Query(query)
	if err != nil {
		log.Println("Error executing query:", err)
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var invenUsedList []InvenUsed

	for rows.Next() {
		var invenUsed InvenUsed
		err := rows.Scan(
			&invenUsed.ID,
			&invenUsed.ItemUsed,
			&invenUsed.UserID,
			&invenUsed.Username,
			&invenUsed.Role,
			&invenUsed.ItemID,
			&invenUsed.ItemName,
			&invenUsed.ItemQty,
			&invenUsed.ItemPrice,
			&invenUsed.ItemDesc,
			&invenUsed.ItemUnit,
			&invenUsed.CompID,
			&invenUsed.CompNos,
			&invenUsed.CompLoc,
			&invenUsed.CompDes,
			&invenUsed.CompStat,
			&invenUsed.CompDate,
		)
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

func GetInvUsedCompId(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	claims := middleware.GetClaims(req)
	if claims.Role != "admin" {
		http.Error(res, "User Unauthorized", http.StatusUnauthorized)
		return
	}

	if err := json.NewDecoder(req.Body).Decode(&CompIdBody); err != nil {
		log.Println(err.Error())
		http.Error(res, "Bad Request", http.StatusBadRequest)
		return
	}

	query := fmt.Sprintf(`
    SELECT 
        iu.id,
        iu.item_used,
        u.user_id,
        u.username,
        u.role,
        i.item_id,
        i.item_name,
        i.item_qty,
        i.item_price,
        i.item_desc,
		i.item_unit,
        c.comp_id,
        c.comp_nos,
        c.comp_loc,
        c.comp_des,
        c.comp_stat,
        c.comp_date
    FROM 
        inven_used iu
    JOIN 
        users u ON iu.user_id = u.user_id
    JOIN 
        inventory i ON iu.item_id = i.item_id
    JOIN 
        complaints c ON iu.comp_id = c.comp_id
	WHERE
		iu.comp_id='%s';
    `, CompIdBody.CompId)

	rows, err := db.Query(query)
	if err != nil {
		log.Println("Error executing query:", err)
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var invenUsedList []InvenUsed

	for rows.Next() {
		var invenUsed InvenUsed
		err := rows.Scan(
			&invenUsed.ID,
			&invenUsed.ItemUsed,
			&invenUsed.UserID,
			&invenUsed.Username,
			&invenUsed.Role,
			&invenUsed.ItemID,
			&invenUsed.ItemName,
			&invenUsed.ItemQty,
			&invenUsed.ItemPrice,
			&invenUsed.ItemDesc,
			&invenUsed.ItemUnit,
			&invenUsed.CompID,
			&invenUsed.CompNos,
			&invenUsed.CompLoc,
			&invenUsed.CompDes,
			&invenUsed.CompStat,
			&invenUsed.CompDate,
		)
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

func DelInvenUsed(res http.ResponseWriter, req *http.Request, db *sql.DB) {

	if err := json.NewDecoder(req.Body).Decode(&delInvenUse); err != nil {
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		log.Println(err.Error())
		return
	}

	query := fmt.Sprintf("SELECT item_id, item_used FROM inven_used WHERE id = '%s'", delInvenUse.ID)
	row := db.QueryRow(query)

	var invenUsed InvenUsed
	row.Scan(&invenUsed.ItemID, &invenUsed.ItemUsed)

	query = fmt.Sprintf("UPDATE inventory SET item_qty = item_qty + %f WHERE item_id = '%s'", invenUsed.ItemUsed, invenUsed.ItemID)

	if _, err := db.Exec(query); err != nil {
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		log.Println(err.Error())
		return
	}

	query = fmt.Sprintf("DELETE FROM inven_used WHERE id = '%s'", delInvenUse.ID)
	if _, err := db.Exec(query); err != nil {
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		log.Println(err.Error())
		return
	}

	res.WriteHeader(http.StatusOK)
	res.Header().Set("Content-Type", "text/plain")
	res.Write([]byte("Item deleted from comp"))
}
