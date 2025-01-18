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
	Id         string `json:"bill_id"`
	DateTime   string `json:"bill_dt"`
	WorkName   string `json:"bill_wn"`
	BillNumber int32  `json:"bill_no"`
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

		err := rows.Scan(&billItem.Id, &billItem.DateTime, &billItem.WorkName, &billItem.BillNumber)
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

	query2 := fmt.Sprintf(`
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
		i.serial_number,
		iu.item_l,
		iu.item_b,
		iu.item_h,
		COALESCE(CAST(iu.bill_id AS TEXT), '') AS bill_id,
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
		iu.bill_id='%s'
	ORDER BY c.comp_nos;
    `, BillBody.BillId)

	rows, err := db.Query(query2)
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
			&invenUsed.SerialNo,
			&invenUsed.ItemL,
			&invenUsed.ItemB,
			&invenUsed.ItemH,
			&invenUsed.BillNo,
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
			log.Println("Error scanning rows: ", err)
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

func GetBillJoinInven(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	var InvenBillBody struct {
		BillNumber int32 `json:"bill_no"`
	}

	if err := json.NewDecoder(req.Body).Decode(&InvenBillBody); err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	query := fmt.Sprintf(`SELECT 
					i.item_id,
					i.item_desc,
					i.item_unit,
					i.item_price,
					i.serial_number,
					SUM(CASE WHEN b.bill_no <= %d THEN iu.item_used ELSE 0 END) AS total_item_used_upto_bill_no,
					SUM(CASE WHEN b.bill_no = %d THEN iu.item_used ELSE 0 END) AS total_item_used_for_given_bill_no
				FROM 
					inventory i
				LEFT JOIN 
					inven_used iu ON i.item_id = iu.item_id
				LEFT JOIN 
					bills b ON iu.bill_id = b.id
				GROUP BY 
					i.item_id, i.item_desc, i.item_unit, i.item_price
				ORDER BY 
					i.serial_number;
				`, InvenBillBody.BillNumber, InvenBillBody.BillNumber)

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
		err := rows.Scan(&invenUsed.ItemID, &invenUsed.ItemDesc, &invenUsed.ItemUnit, &invenUsed.ItemPrice, &invenUsed.SerialNo, &invenUsed.UptoUse, &invenUsed.ItemUsed)
		if err != nil {
			log.Println("Error scanning rows: ", err)
			http.Error(res, "Internal Server Error", http.StatusInternalServerError)
			return
		}
		invenUsed.UptoAmt = invenUsed.UptoUse * invenUsed.ItemPrice
		invenUsedList = append(invenUsedList, invenUsed)
	}

	res.Header().Set("Content-Type", "application/json")
	if err := json.NewEncoder(res).Encode(invenUsedList); err != nil {
		log.Println("Error encoding JSON:", err)
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}
}
