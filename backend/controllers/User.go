package controllers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/bikram-ghuku/CMS/backend/models"
	"github.com/bikram-ghuku/CMS/backend/services"
	"github.com/golang-jwt/jwt/v5"
	"golang.org/x/crypto/bcrypt"
)

var user struct {
	Uname string `json:"uname"`
	Pswd  string `json:"pswd"`
}

var resStruct struct {
	Msg string `json:"msg"`
}

type LoginJwtFields struct {
	Uname string `json:"uname"`
	Role  string `json:"role"`
}

type LoginJwtClaims struct {
	LoginJwtFields
	jwt.RegisteredClaims
}

func Register(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	if err := json.NewDecoder(req.Body).Decode(&user); err != nil {
		log.Println(err.Error())
		http.Error(res, "Bad Request", http.StatusBadRequest)
		return
	}

	hashPswd, err := services.HashPassword(user.Pswd)
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}
	_, err = db.Exec(fmt.Sprintf("INSERT INTO users(username, pswd) VALUES('%s', '%s')", user.Uname, hashPswd))
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	http.Header.Add(res.Header(), "content-type", "application/json")
	resStruct.Msg = "User Register Success"

	if err = json.NewEncoder(res).Encode(&resStruct); err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}
}

func Login(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	jwt_secret := os.Getenv("JWT_SECRET")
	if err := json.NewDecoder(req.Body).Decode(&user); err != nil {
		log.Println(err.Error())
		http.Error(res, "Bad Request", http.StatusBadRequest)
		return
	}

	row := db.QueryRow(`SELECT * FROM users WHERE username= $1`, user.Uname)

	DB_user := models.User{}

	err := row.Scan(&DB_user.UserID, &DB_user.Username, &DB_user.Password, &DB_user.Role)
	if err != nil && err != sql.ErrNoRows {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	err = bcrypt.CompareHashAndPassword([]byte(DB_user.Password), []byte(user.Pswd))
	if err != nil {
		log.Println(err.Error())
		http.Error(res, "Wrong Password", http.StatusUnauthorized)
		return
	}

	issueTime := time.Now()
	expiryTime := issueTime.AddDate(0, 0, 90)

	claims := &LoginJwtClaims{
		LoginJwtFields: LoginJwtFields{Uname: DB_user.Username, Role: string(DB_user.Role)},
		RegisteredClaims: jwt.RegisteredClaims{
			IssuedAt:  jwt.NewNumericDate(issueTime),
			ExpiresAt: jwt.NewNumericDate(expiryTime),
		},
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)

	tokenString, err := token.SignedString([]byte(jwt_secret))
	if err != nil {
		fmt.Println("Error Sigining JWT: ", err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}

	cookie := http.Cookie{
		Name:     "heimdall",
		Value:    tokenString,
		Expires:  expiryTime,
		HttpOnly: true,
		Secure:   true,
		SameSite: http.SameSiteNoneMode,
		Path:     "/",
	}

	http.SetCookie(res, &cookie)
	res.WriteHeader(http.StatusOK)
	res.Header().Set("Content-Type", "text/plain")
	res.Write([]byte("Login Successful"))
}
