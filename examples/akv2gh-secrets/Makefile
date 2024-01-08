.PHONY: all
all: build run

.PHONY: build
build:
	CGO_ENABLED=0 go build -installsuffix 'static' -o akv2gh ./cmd/akv2gh
.PHONY: run
run:
	./akv2gh --file ./secrets.yaml apply
