# This file should be used to bootstrap a mac install of this configuration project

source ./shared_bootstrap_funcs.sh

clone_important_repos()
install_nix()
install_nix_darwin()
install_homemanager()
link_config_files()
#install_homemanager_post()
#install_emacs()
#install_addition_linux_packages()
#install_docker()


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

# Link the emacs app to the applications folder after it has been installed with homebrew
ln -s /opt/homebrew/opt/emacs-plus@27/Emacs.app /Applications
