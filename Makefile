.PHONY: server install-statik generate install run build release-build release check-clean clean

VERSION = $(shell git describe --tags 2> /dev/null || echo unknown)
VERSION_ID = $(VERSION)-$(GOOS)-$(GOARCH)
PKG = github.com/pilosa/webui

clean:
	rm -rf vendor build

vendor: Gopkg.toml
	dep ensure
	touch vendor

server:
	cd assets && python -m SimpleHTTPServer

install-statik:
	go get -u github.com/rakyll/statik

generate: vendor
	go generate $(PKG)/pkg/static

install: vendor generate
	go install $(PKG)/cmd/pilosa-webui

run: vendor generate
	go run $(PKG)/cmd/pilosa-webui/main.go

build: vendor generate
	go build $(FLAGS) $(PKG)/cmd/pilosa-webui

release-build:
	$(MAKE) build FLAGS="-o build/pilosa-webui-$(VERSION_ID)/pilosa-webui"
	cp COPYING README.md build/pilosa-webui-$(VERSION_ID)
	tar -cvz -C build -f build/pilosa-webui-$(VERSION_ID).tar.gz pilosa-webui-$(VERSION_ID)/
	@echo Created release build: build/pilosa-webui-$(VERSION_ID).tar.gz

release: check-clean
	$(MAKE) release-build GOOS=darwin GOARCH=amd64
	$(MAKE) release-build GOOS=linux GOARCH=amd64
	$(MAKE) release-build GOOS=linux GOARCH=386

check-clean:
ifndef SKIP_CHECK_CLEAN
	$(if $(shell git status --porcelain),$(error Git status is not clean! Please commit or checkout/reset changes.))
endif
