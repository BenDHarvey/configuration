#!/usr/bin/env bash
set -euo pipefail

set -e
trap 'catch $? $LINENO' EXIT
catch() {
  if [ "$1" != "0" ]; then
    # error handling goes here
    echo "Error $1 occurred on $2"
  fi
}

echo "Installing a workstation config"

# Work out what architecture the machine we are running on is
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=mac;;
    *)          machine="UNKNOWN:${unameOut}"
esac

unameArch="$(uname -p)"
case "${unameArch}" in
    arm*)     machineArch=arm;;
    *)        machineArch="UNKNOWN:${unameOut}"
esac

echo "[architecture] - Found that we have a $machine OS running on $machineArch architecture"

#####
# Install ansible on a linux machine
#####
if [ "$machine" = "linux" ]; then

  echo "[ansible install] - Installing ansible on linux machine"
  echo "[linux dependancies] - Installing Ansible dependencies and Git."

  sudo apt-get update
  sudo apt-get install python3 -y
  sudo apt-get install python3-pip -y

  sudo apt-get install gnupg -y

  pip3 install ansible

  wget https://github.com/mozilla/sops/releases/download/v3.6.1/sops_3.6.1_amd64.deb
  sudo dpkg -i sops_3.6.1_amd64.deb

  # Update the path so the the newly installed ansible packages can be used
  export PATH=$PATH:~/.local/bin

  # Update bashrc so that gpg works correctly
  echo 'GPG_TTY=$(tty)' >> ~/.bashrc 
  echo 'export GPG_TTY' >> ~/.bashrc 
  source ~/.bashrc

  export GPG_TTY=$(tty)
fi

if [ "$machine" = "mac" ]; then
  echo "[homebrew] - Found that machine is macos. Installing or updating homebrew "

  if test ! $(which brew); then
      echo "[homebrew] - Did not find existing installation. Installing homebrew"
     /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  else
    echo "[homebrew] - Homebrew is already installed. Updating"
    brew update
  fi

  tset

  echo "[homebrew] - Installing initial homebrew packages"
  brew install ansible sops gpg
fi

TEMP_DIR="/tmp/configuration"

echo "[git] - cloning the configuration repository to $TEMP_DIR"
if [ -d "$TEMP_DIR" ]; then rm -Rf $TEMP_DIR; fi
git clone https://gitlab.com/benharvey/configuration.git /tmp/configuration

echo "[ansible] - Installing required ansible pacakges"
ansible-galaxy install -r /tmp/configuration/ansible-requirements.yml

echo "[ansible] - Running initial ansible run"
ansible-playbook -u $(whoami) /tmp/configuration/endpoints/workstation-initial.yml
