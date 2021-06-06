#!/usr/bin/env bash
set -euo pipefail

## This script is for testing purposes
## Should remove everything that get installed to allow for local testing
sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
sudo rm -r /opt/homebrew
sudo rm -r ~/.ansible
sudo rm -r /tmp/configuration
sudo rm -r ~/.configuration