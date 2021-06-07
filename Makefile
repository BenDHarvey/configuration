# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

EXECUTABLES = ansible-playbook
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

SHELL := /bin/bash

.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

config-workstation: ## Run configuration for a workstation
	ansible-playbook workstation/workstation.yml

initial-config-workstation: ## Run configuration of a workstation for the first time
	bash ./orchestration_scripts/install_workstation.sh

deploy-git: ## Runs terraform scripts to create and configurate git repos
	bash ./orchestration_scripts/deploy_git.sh
