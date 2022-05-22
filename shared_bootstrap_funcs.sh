#!/usr/bin/env bash

apt_update_system() {
  echo "=== Starting system update ==="
  sudo apt update && sudo apt upgrade -y

  echo ""
  echo "=== Done ==="
  echo ""
}

clone_important_repos() {
  echo "=== Starting repo clone ==="
  git clone git@github.com:BenDHarvey/org.git ~/Documents/org
  
  echo ""
  echo "=== Done ==="
  echo ""
}

install_nix() {
  echo "=== Starting nix install ==="
  # Install nix
  curl -L https://nixos.org/nix/install | sh

  # source the nix shell script
  . /home/ben/.nix-profile/etc/profile.d/nix.sh

  echo ""
  echo "=== Done ==="
  echo ""
}

install_homemanager() {
  echo "=== Starting nix home-manager install ==="
  # Install home-manager
  nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
  nix-channel --update

  # Add environment variable for home-manager
  echo 'export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH' >> ~/.bashrc

  nix-shell '<home-manager>' -A install

  echo ""
  echo "=== Done ==="
  echo ""
}

install_nix_darwin() {
  echo "=== Starting nix darwin install ==="
  # Install nix-darwin on the system
  # This also comes straight from the nix-darwin github page
  nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
  ./result/bin/darwin-installer
  echo ""
  echo "=== Done ==="
  echo ""
}

install_homemanager_post() {
  echo "=== Starting nix home-manager post intall steps ==="
  # Apply the home-manager config
  home-manager switch -b backup

  # Make zsh the default terminal
  sudo chsh -s $(which zsh)
  echo ""
  echo "=== Done ==="
  echo ""
}

link_config_files() {
  echo "=== Starting link config files ==="
  # Link default.nix file from .configuration repo to local home directory
  rm ~/.config/nixpkgs/home.nix || true
  rm ~/.config/nixpkgs/config.nix || true
  ln -s ~/.configuration/nix/home.nix ~/.config/nixpkgs/home.nix || true
  ln -s ~/.configuration/nix/config.nix ~/.config/nixpkgs/config.nix || true

  echo ""
  echo "=== Done ==="
  echo ""
}

install_addition_linux_packages() {
  echo "=== Starting link config files ==="

  sudo add-apt-repository ppa:regolith-linux/release
  sudo apt-get update
 
    sudo apt install -y i3-gaps \
        libsqlite3-dev \
        sqlite3 \
        gcc \
        texlive-latex-base \
        texlive-fonts-recommended \
        texlive-fonts-extra \
        texlive-latex-extra

  # nix has some trouble with loading graphicall app the fix is to install this
  #https://github.com/guibou/nixGL/
  nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
  nix-env -iA nixgl.auto.nixGLDefault

  echo ""
  echo "=== Done ==="
  echo ""
}

install_emacs() {
  echo "=== Starting doom emacs install ==="
  # Install doom emacs
  git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
  ~/.emacs.d/bin/doom install

  echo ""
  echo "=== Done ==="
  echo ""
}


install_docker() {
  curl -fsSL https://get.docker.com -o get-docker.sh
  sh get-docker.sh
}
