#!/usr/bin/env bash

ansible-playbook servers/pre-deploy.yml

cd /tmp/kubespray/

ansible-playbook -i inventory/mycluster/inventory.yml --ask-become-pass cluster.yml

