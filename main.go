package main

import (
	"net/http"
	"log"
	"html/template"
)

var tmpl = template.Must(template.ParseFiles("index.html"))

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		if err := tmpl.Execute(w, nil); err != nil {
			log.Println("Error executing template:", err)
		}
	})

	log.Println("Server started at http://localhost:8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		log.Fatal(err)
	}
}
