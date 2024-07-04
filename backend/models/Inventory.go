package models

import "github.com/google/uuid"

type Inventory struct {
	ItemID    uuid.UUID `db:"item_id"`
	ItemName  string    `db:"item_name"`
	ItemQty   float64   `db:"item_qty"`
	ItemPrice float64   `db:"item_price"`
	ItemDesc  string    `db:"item_desc"`
}
