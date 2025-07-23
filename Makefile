.PHONY: test run goose-up goose-down goose-status goose-create goose-reset

export CGO_ENABLED=1

test:
	go test ./...

run: migrate-up
	go run main.go

goose-up:
	goose -dir db/migrations sqlite3 db/prism.db up

goose-down:
	goose -dir db/migrations sqlite3 db/prism.db down

goose-reset:
	goose -dir db/migrations sqlite3 db/prism.db reset

goose-status:
	goose -dir db/migrations sqlite3 db/prism.db status

goose-create:
	@read -p "Enter migration name: " name; \
	goose -dir db/migrations create $$name sql

goose-cities:
	goose -dir db/migrations create add_cities sql
