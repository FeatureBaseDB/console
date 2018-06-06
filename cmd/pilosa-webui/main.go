package main

import (
	"flag"
	"log"
	"net/http"
	"regexp"

	"github.com/pkg/errors"
	"github.com/rakyll/statik/fs"

	_ "github.com/pilosa/webui/pkg/static/statik"
)

var bind = flag.String("bind", ":8000", "bind address")

func main() {
	var port string
	flag.Parse()
	re := regexp.MustCompile(":(\\d{1,5})$")
	match := re.FindStringSubmatch(*bind)
	if len(match) == 2 {
		port = match[1]
	} else {
		log.Fatalf("Invalid bind address: %s", *bind)
	}
	webAddress := "http://localhost:" + port

	statikFS, err := fs.New()
	if err != nil {
		log.Fatal(errors.Wrap(err, "initializing statik filesystem"))
	}

	http.Handle("/", http.FileServer(statikFS))

	log.Println("Serving Pilosa WebUI at " + webAddress)
	err = http.ListenAndServe(*bind, nil)
	if err != nil {
		log.Fatal(errors.Wrap(err, "running ListenAndServe"))
	}
}
