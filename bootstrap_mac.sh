# This file should be used to bootstrap a mac install of this configuration project

# Install nix on the system
# This comes straight from the nix website
# https://nixos.org/download.html#nix-install-macos
sh <(curl -L https://nixos.org/nix/install) # Run this command and then follow the prompts

# Install nix-darwin on the system
# This also comes straight from the nix-darwin github page
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer

# Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

# Move configuration files for nix-darwin
ln -s ~/.configuration/nix/modules/home/darwin-configuration-work.nix /Users/ben.harvey/.nixpkgs/darwin-configuration.nix
ln -s ~/.configuration/nix/modules/home/home.nix ~/.config/nixpkgs/home.nix
ln -s ~/.configuration/nix/modules/home/config.nix ~/.config/nixpkgs/config.nix

# Install doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# Run inital nix generation
darwin-rebuild switch
home-manager switch -b backup # if there are existing file the backup flag is needed