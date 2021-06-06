#!/usr/bin/env bash
set -euo pipefail

GITHUB_TOKEN=$(sops -d --extract '["github"]["access_token"]' ./secrets/git.yaml)
PUBLIC_KEY=$(sops -d --extract '["ssh_keys"]["personal_public_key"]' ./secrets/ssh.yaml)
DEPLOY_PUBLIC_KEY=$(sops -d --extract '["ssh_keys"]["git_deploy_key_public"]' ./secrets/ssh.yaml)

cd ./git

terraform init
TF_VAR_github_token=$GITHUB_TOKEN \
    TF_VAR_public_key=$PUBLIC_KEY \
    TF_VAR_deploy_public_key=$DEPLOY_PUBLIC_KEY \
    terraform apply
