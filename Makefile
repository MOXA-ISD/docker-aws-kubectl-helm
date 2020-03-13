
# HELP
.PHONY: help

PROJECT_ENV ?= project.env
include $(PROJECT_ENV)
export $(shell sed 's/=.*//' $(PROJECT_ENV))

# alias
b: build
p: push
c: clean

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build images, alias: b
	@docker build -f Dockerfile . -t $(GROUP_NAME)/$(IMAGE_NAME):latest
	@docker tag $(GROUP_NAME)/$(IMAGE_NAME):latest $(GROUP_NAME)/$(IMAGE_NAME):$(VERSION)


push: ## Push images, alias: p
	@docker push $(GROUP_NAME)/$(IMAGE_NAME):latest
	@docker push $(GROUP_NAME)/$(IMAGE_NAME):$(VERSION)

clean: ## Delete local images, alias: c
	@docker rmi $(GROUP_NAME)/$(IMAGE_NAME):latest
	@docker rmi $(GROUP_NAME)/$(IMAGE_NAME):$(VERSION)
