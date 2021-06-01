set -euo pipefail

GITLAB_TOKEN=$(sops -d --extract '["gitlab"]["terraform_token"]' ./secrets/git.yaml)

echo $GITLAB_TOKEN

cd ./git

TF_VAR_gitlab_token=$GITLAB_TOKEN terraform refresh


