package main

import (
	"log"
	"net/http"

	"github.com/rakyll/statik/fs"

	_ "github.com/pilosa/webui/pkg/static/statik"
)

func main() {

	statikFS, err := fs.New()
	if err != nil {
		log.Fatal(err)
	}

	http.Handle("/", http.FileServer(statikFS))

	log.Println("Serving Pilosa WebUI at http://localhost:8000")
	http.ListenAndServe(":8000", nil)
}
