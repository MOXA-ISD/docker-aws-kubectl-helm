
# HELP
.PHONY: help

PROJECT_CONFIG ?= config.ini
include $(PROJECT_CONFIG)
export $(shell sed 's/=.*//' $(PROJECT_CONFIG))

# alias
b: build
r: run
p: push
c: clean

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build image, alias: b
	@docker build -f Dockerfile . -t $(ORG_NAME)/$(IMAGE):latest
	@docker tag $(ORG_NAME)/$(IMAGE):latest $(ORG_NAME)/$(IMAGE):$(VERSION)

run: ## Run image, alias r
	@docker run -it $(ORG_NAME)/$(IMAGE):latest bash

push: ## Push image, alias: p
	@docker push $(ORG_NAME)/$(IMAGE):latest
	@docker push $(ORG_NAME)/$(IMAGE):$(VERSION)

clean: ## Delete local image, alias: c
	@docker rmi $(ORG_NAME)/$(IMAGE):latest
	@docker rmi $(ORG_NAME)/$(IMAGE):$(VERSION)
