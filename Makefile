REGISTRY = iamliamnorton
PROJECT	= draft
TAG ?= latest

IMAGE = $(REGISTRY)/$(PROJECT):$(TAG)

.PHONY: build
build:
	docker build --rm -t $(IMAGE) .

.PHONY: test
test:
	docker-compose build && \
	  docker-compose run app ./ci/env/test.sh ./ci/test.sh

.PHONY: shell
shell:
	docker-compose run app bash

.PHONY: run
run:
	docker-compose build && \
	  docker-compose up

.PHONY: push
push:
	docker push $(IMAGE)
