#!/usr/bin/env bash
set -euo pipefail

GITHUB_TOKEN=$(sops -d --extract '["github"]["access_token"]' ./secrets/git.yaml)

cd ./git

terraform init
TF_VAR_github_token=$GITHUB_TOKEN terraform apply
