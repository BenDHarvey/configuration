#!/usr/bin/env bash
# Script to deploy cloud terraform asssets

export TF_VAR_LINODE_TOKEN=$(sops -d --extract '["linode_token"]' ./secrets/linode.yaml)

cd cloud/linode/terraform

terraform destroy
