# /bin/bash

# This script is a collection of commands that can be used to bootstrap a pop_os install and get it running with configuration stored here

sudo apt update && sudo apt upgrade -y

# Install nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# Reboot
sudo reboot

# Install 1password

# Copy SSH key and pgp keys
echo "COPY SSH AND PGP FROM THUMBDRIVE
This step has not been automated yet. You will have to do this manually"

# Update permissions of the copied ssh keys

# clone configuration repo



# Run inital 
