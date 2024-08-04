package models

import "github.com/google/uuid"

type Inventory struct {
	ItemNo    float64   `json:"item_nos"`
	ItemID    uuid.UUID `db:"item_id" json:"item_id"`
	ItemName  string    `db:"item_name" json:"item_name"`
	ItemQty   float64   `db:"item_qty" json:"item_qty"`
	ItemPrice float64   `db:"item_price" json:"item_price"`
	ItemDesc  string    `db:"item_desc" json:"item_desc"`
	ItemUnit  string    `db:"item_unit" json:"item_unit"`
}
