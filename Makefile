.PHONY: test run

export CGO_ENABLED=1

test:
	go test ./...

run: 
	go run main.go
