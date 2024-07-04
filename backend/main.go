package main

import (
	"log"
	"net/http"
)

func main() {

	log.Println("Listening on port: 8000")
	if err := http.ListenAndServe("0.0.0.0:8000", http.DefaultServeMux); err != nil {
		log.Panicln(err.Error())
	}
}
