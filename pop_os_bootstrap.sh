# /bin/bash

# This script is a collection of commands that can be used to bootstrap a pop_os install and get it running with configuration stored here

sudo apt update && sudo apt upgrade -y

# Copy SSH key and pgp keys
echo "COPY SSH AND PGP FROM THUMBDRIVE
This step has not been automated yet. You will have to do this manually"

# Set the correct permissions on all the key files
chmod 600 ~/.ssh/id_rsa_*

# clone some repos
git clone git@github.com:BenDHarvey/configuration.git ~/.configuration
git clone git@github.com:BenDHarvey/org.git ~/Documents/org

# Install i3
sudo apt install i3

# Install nix
curl -L https://nixos.org/nix/install | sh

# source the nix shell script
. /home/ben/.nix-profile/etc/profile.d/nix.sh

# Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Add environment variable for home-manager
echo 'export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH' >> ~/.bashrc

nix-shell '<home-manager>' -A install

# Link default.nix file from .configuration repo to local home directory
rm ~/.config/nixpkgs/home.nix
rm ~/.config/nixpkgs/config.nix
ln -s ~/.configuration/nix/modules/home/home.nix ~/.config/nixpkgs/home.nix
ln -s ~/.configuration/nix/modules/home/config.nix ~/.config/nixpkgs/config.nix

# Apply the home-manager config
home-manager switch -b backup

# Make zsh the default terminal
sudo chsh -s $(which zsh)

# nix has some trouble with loading graphicall app the fix is to install this
#https://github.com/guibou/nixGL/
nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault

# Install doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

#Install docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh