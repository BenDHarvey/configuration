# /bin/bash

# This script is a collection of commands that can be used to bootstrap a pop_os install and get it running with configuration stored here

sudo apt update && sudo apt upgrade -y

# Install i3
sudo apt install i3

# Install nix
curl -L https://nixos.org/nix/install | sh

# Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install

# Add environment variable for home-manager
echo 'export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH' >> ~/.bashrc 

# Copy SSH key and pgp keys
echo "COPY SSH AND PGP FROM THUMBDRIVE
This step has not been automated yet. You will have to do this manually"

# clone configuration repo
git clone git@github.com:BenDHarvey/configuration.git ~/.configuration

# Link default.nix file from .configuration repo to local home directory
rm ~/.config/nixpkgs/home.nix
ln -s ~/.configuration/nix/modules/home/home.nix ~/.config/nixpkgs/home.nix

# Apply the home-manager config
home-manager switch

# Make zsh the default terminal
sudo chsh -s $(which zsh)