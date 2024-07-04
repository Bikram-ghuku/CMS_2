package controllers

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/bikram-ghuku/CMS/backend/models"
	"github.com/bikram-ghuku/CMS/backend/services"
	"golang.org/x/crypto/bcrypt"
)

var user struct {
	Uname string `json:"uname"`
	Pswd  string `json:"pswd"`
}

var resStruct struct {
	Msg string `json:"msg"`
}

func Register(res http.ResponseWriter, req *http.Request, db *sql.DB) {
	if err := json.NewDecoder(req.Body).Decode(&user); err != nil {
		log.Println(err.Error())
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
	if err := json.NewDecoder(req.Body).Decode(&user); err != nil {
		log.Println(err.Error())
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
		http.Error(res, "Password Wrong", http.StatusUnauthorized)
		return
	}

	http.Header.Add(res.Header(), "content-type", "application/json")
	resStruct.Msg = "User Login Success"

	if err = json.NewEncoder(res).Encode(&resStruct); err != nil {
		log.Println(err.Error())
		http.Error(res, "Internal Server Error", http.StatusInternalServerError)
		return
	}
}
