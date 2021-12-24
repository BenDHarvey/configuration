# /bin/bash

# This script is a collection of commands that can be used to bootstrap a pop_os install and get it running with configuration stored here

sudo apt update && sudo apt upgrade -y

# Install nix
curl -L https://nixos.org/nix/install | sh

# Reboot
sudo reboot

# Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Add environment variable for home-manager
echo 'export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH' >> ~/.bashrc 

# Copy SSH key and pgp keys
echo "COPY SSH AND PGP FROM THUMBDRIVE
This step has not been automated yet. You will have to do this manually"

# clone configuration repo

# Link default.nix file from .configuration repo to local home directory
rm ~/.config/nixpkgs/home.nix
ln -s ~/.configuration/nix/modules/home/home.nix ~/.config/nixpkgs/home.nix
