package models

import (
	"time"

	"github.com/google/uuid"
)

type CompStatus string

const (
	CompOpen  CompStatus = "open"
	CompClose CompStatus = "close"
)

type Complaint struct {
	CompID      uuid.UUID  `db:"comp_id"`
	CompNos     string     `db:"comp_nos"`
	CompLoc     string     `db:"comp_loc"`
	CompDes     string     `db:"comp_des"`
	CompStat    CompStatus `db:"comp_stat"`
	CompDate    time.Time  `db:"comp_date"`
	FinDatetime time.Time  `db:"fin_datetime"`
	FinText     string     `db:"fin_text"`
}
