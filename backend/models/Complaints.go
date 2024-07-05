package models

import (
	"database/sql"
	"time"

	"github.com/google/uuid"
)

type CompStatus string

const (
	CompOpen  CompStatus = "open"
	CompClose CompStatus = "closed"
)

type Complaint struct {
	CompID      uuid.UUID      `db:"comp_id" json:"comp_id"`
	CompNos     string         `db:"comp_nos" json:"comp_nos"`
	CompLoc     string         `db:"comp_loc" json:"comp_loc"`
	CompDes     string         `db:"comp_des" json:"comp_des"`
	CompStat    CompStatus     `db:"comp_stat" json:"comp_stat"`
	CompDate    time.Time      `db:"comp_date" json:"comp_date"`
	FinDatetime sql.NullTime   `db:"fin_datetime" json:"fin_datetime"`
	FinText     sql.NullString `db:"fin_text" json:"fin_text"`
}
