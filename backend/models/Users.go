package models

import (
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
)

type UserRole string

const (
	RoleAdmin       UserRole = "admin"
	RoleInvenManage UserRole = "inven_manage"
	RoleWorker      UserRole = "worker"
)

type User struct {
	UserID   uuid.UUID `db:"user_id"`
	Username string    `db:"username"`
	Password string    `db:"pswd"`
	Role     UserRole  `db:"role"`
}

type LoginJwtFields struct {
	Uname string `json:"uname"`
	Role  string `json:"role"`
}

type LoginJwtClaims struct {
	LoginJwtFields
	jwt.RegisteredClaims
}
