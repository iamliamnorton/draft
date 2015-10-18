REGISTRY = iamliamnorton
PROJECT	= draft
TAG ?= latest

IMAGE = $(REGISTRY)/$(PROJECT):$(TAG)

.PHONY: build
build:
	docker-compose build && \
	  docker build --rm -t $(IMAGE) .

.PHONY: test
test:
	docker-compose build && \
	  docker-compose run app ./ci/env/test.sh ./ci/test.sh

.PHONY: shell
shell:
	docker-compose build && \
	  docker-compose run app bash

.PHONY: run
run:
	docker-compose build && \
	  docker-compose up

.PHONY: push
push:
	docker build --rm -t $(IMAGE) . && \
	  docker push $(IMAGE)

.PHONY: db
db:
	docker-compose run app rake db:drop && \
	  docker-compose run app rake db:create && \
	  docker-compose run app rake db:migrate && \
	  docker-compose run app rake db:seed && \
	  docker-compose run app rake import:nba_games && \
	  docker-compose run app rake import:nba_players
