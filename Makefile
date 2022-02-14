# Author: noi.narisak@gmail.com
# Date:
# Desc:

.ONESHELL:
.SHELL := /usr/bin/bash
.DEFAULT_GOAL := help

ROOT_PATH := $(abspath $(dir $(lastword $(MAKEFILE_LIST)))/../..)

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

.PHONY: clean
clean: ## Clean up
	@echo "+ $@"
	@find . -type f -name '*.pyc' -exec rm -f {} +
	@find . -type d -name '*__pycache__*' -exec rm -rf {} +
	# @find . -type d -name 'venv' -exec rm -rf {} +

.PHONY: build
build: clean ## Build
	@echo "+ $@"
	@docker-compose build

.PHONY: run
run:  ## Run
	@echo "+ $@"
	@docker-compose up

.PHONY: test
test: ## Run test
	@echo "+ $@"
	@docker-compose exec web pytest
