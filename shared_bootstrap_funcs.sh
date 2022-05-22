#!/usr/bin/env bash

apt_update_system() {
  sudo apt update && sudo apt upgrade -y
}

clone_important_repos() {
    git clone git@github.com:BenDHarvey/org.git ~/Documents/org
}

install_nix() {
  # Install nix
  curl -L https://nixos.org/nix/install | sh

  # source the nix shell script
  . /home/ben/.nix-profile/etc/profile.d/nix.sh
}

install_homemanager() {
  # Install home-manager
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update

  # Add environment variable for home-manager
  echo 'export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH' >> ~/.bashrc

  nix-shell '<home-manager>' -A install
}

install_nix_darwin() {
  # Install nix-darwin on the system
  # This also comes straight from the nix-darwin github page
  nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
  ./result/bin/darwin-installer
}

install_homemanager_post() {
  # Apply the home-manager config
  home-manager switch -b backup

  # Make zsh the default terminal
  sudo chsh -s $(which zsh)
}

link_config_files() {
  # Link default.nix file from .configuration repo to local home directory
  rm ~/.config/nixpkgs/home.nix || true
  rm ~/.config/nixpkgs/config.nix || true
  ln -s ~/.configuration/nix/home.nix ~/.config/nixpkgs/home.nix || true
  ln -s ~/.configuration/nix/config.nix ~/.config/nixpkgs/config.nix || true
}

install_addition_linux_packages() {
    sudo apt install -y i3 \
        libsqlite3-dev \
        sqlite3 \
        ruby \
        ruby-dev \
        gcc \
        texlive-latex-base \
        texlive-fonts-recommended \
        texlive-fonts-extra \
        texlive-latex-extra

  # nix has some trouble with loading graphicall app the fix is to install this
  #https://github.com/guibou/nixGL/
  nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
  nix-env -iA nixgl.auto.nixGLDefault

  # Install pgadmin4
  curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
  sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
  sudo apt install pgadmin4 -y

  sudo gem install rails
}

install_emacs() {
  # Install doom emacs
  git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
  ~/.emacs.d/bin/doom install
}


install_docker() {
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
}
