package models

import "github.com/google/uuid"

type InvenUsed struct {
	ID       uuid.UUID `db:"id"`
	UserID   uuid.UUID `db:"user_id"`
	CompID   uuid.UUID `db:"comp_id"`
	ItemID   uuid.UUID `db:"item_id"`
	ItemUsed float64   `db:"item_used"`
}
