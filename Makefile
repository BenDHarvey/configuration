# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

#EXECUTABLES = ansible-playbook
#K := $(foreach exec,$(EXECUTABLES),\
#        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

SHELL := /bin/bash

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS
# Build the container
workstation: ## Run configuration for a workstation
	ansible-playbook workstation/workstation.yml
