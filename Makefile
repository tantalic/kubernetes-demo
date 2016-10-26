VERSION = 1.0.0

.PHONY: help
.DEFAULT_GOAL := help

build: linux docker ## Build docker image

run: ## Run docker container, availalbe on http://localhost:3456
	docker run -it -p 3456:80 --rm tantalic/kubernetes-demo:$(VERSION)

push: ## Push docker image to docker hub
	docker push tantalic/kubernetes-demo:$(VERSION)

linux: # Build static binary for linux
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -a -tags netgo -ldflags '-w' -o demo-linux-amd64

docker: linux 
	docker build -t tantalic/kubernetes-demo:$(VERSION) .

clean: ## Removes docker image
	docker rmi tantalic/kubernetes-demo:$(VERSION)

help: ## List available make commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
