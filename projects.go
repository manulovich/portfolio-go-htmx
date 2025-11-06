package main

import (
	"net/http"
	"encoding/json"
)

func projectsHandler(w http.ResponseWriter, r *http.Request) {
	projects := []string{"Проект 1", "Проект 2", "Проект 3"}
	json.NewEncoder(w).Encode(projects)
}
