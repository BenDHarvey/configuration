# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html

#EXECUTABLES = ansible-playbook
K := $(foreach exec,$(EXECUTABLES),\
        $(if $(shell which $(exec)),some string,$(error "No $(exec) in PATH")))

SHELL := /bin/bash

.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

link-nix: ## Link the nix config file from this dir to their correct locations
	rm -rvf ~/.config/nixpkgs/home.nix
	rm -rvf ~/.nixpkgs/darwin-configuration.nix

	ln -s ~/.configuration/nix/home.nix ~/.config/nixpkgs/home.nix
	ln -s ~/.configuration/nix/darwin-configuration.nix ~/.nixpkgs/darwin-configuration.nix

create-dirs: ## Create all the common directories that I ues
	mkdir -p ~/Workspace/github.com/BenDHarvey
	mkdir -p ~/Workspace/github.com/nib-group
	mkdir -p ~/Mail/ben@harvey.onl/

clone-repos: ## Clone important repos that I use a lot
	# BenDHarvey repos
	git clone git@github.com:BenDHarvey/homelab.git ~/Workspace/github.com/BenDHarvey/homelab || true
  git clone git@github.com:BenDHarvey/org.git ~/Documents/org

mount: ## Mount some important directories to local machine
	# Make the nfs directories to make sure they are present before mounting
	mkdir -p ~/nfs_mounts/media

	# NFS will translate any root operations on the client to the nobody:nogroup credentials as a security measure.
	# Therefore, we need to change the directory ownership to match those credentials.
	sudo chown nobody:nogroup ~/nfs_mounts/media

	# Use nfs to mount the directory
	sudo mount 192.168.30.5:/mnt/HD/HD_b2/media ~/nfs_mounts/media
