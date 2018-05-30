.PHONY: server install-statik generate install run

server:
	cd assets && python -m SimpleHTTPServer

install-statik:
	go get -u github.com/rakyll/statik

generate:
	go generate github.com/pilosa/webui/pkg/static

install:
	go install github.com/pilosa/webui/cmd/pilosa-webui

run:
	go run cmd/pilosa-webui/main.go
