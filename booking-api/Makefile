.PHONY: build clean deploy

build:
	env GOOS=linux GOARCH=amd64 CGO_ENABLED=0  go build -ldflags="-s -w" -o bin/register register/main.go
	env GOOS=linux GOARCH=amd64 CGO_ENABLED=0  go build -ldflags="-s -w" -o bin/login login/main.go
	env GOOS=linux GOARCH=amd64 CGO_ENABLED=0  go build -ldflags="-s -w" -o bin/authorizer authorizer/main.go

clean:
	rm -rf ./bin

deploy: clean build
	sls deploy --verbose
