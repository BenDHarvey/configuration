# /bin/bash

source ./shared_bootstrap_funcs.sh

apt_update_system
clone_important_repos
install_nix
install_homemanager
link_config_files
install_homemanager_post
install_emacs

install_regolith_desktop

install_addition_linux_packages
#install_docker()
