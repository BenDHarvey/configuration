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

export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
nix-shell '<home-manager>' -A install

# Move configuration files for nix-darwin
ln -s ~/.configuration/nix/darwin-configuration-work.nix /Users/ben.harvey/.nixpkgs/darwin-configuration.nix
# For a work setup use the following commented line instead
# ln -s ~/.configuration/nix/work.nix ~/.config/nixpkgs/home.nix
ln -s ~/.configuration/nix/modules/home.nix ~/.config/nixpkgs/home.nix
ln -s ~/.configuration/nix/config.nix ~/.config/nixpkgs/config.nix

# Install doom emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install

# Run inital nix generation
darwin-rebuild switch
home-manager switch -b backup # if there are existing file the backup flag is needed
