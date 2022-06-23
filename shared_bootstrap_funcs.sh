# /bin/bash

apt_update_system() {
  echo "=== Starting system update ==="
  sudo apt update && sudo apt upgrade -y

  echo ""
  echo "=== Done ==="
  echo ""
}

clone_important_repos() {
  echo "=== Starting repo clone ==="

  make create-dirs
  make clone-repos

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

install_i3_gaps() {
  echo "=== Starting i3-gaps install ==="

  wget -qO - https://regolith-linux.github.io/package-repo/regolith.key | sudo tee /etc/apt/trusted.gpg.d/regolith.asc

  echo deb "[arch=amd64] https://regolith-release-ubuntu-jammy-amd64.s3.amazonaws.com jammy main" | \
  sudo tee /etc/apt/sources.list.d/regolith.list

  sudo apt update
  sudo apt install i3-gaps -y
  sudo apt upgrade

  echo ""
  echo "=== Done ==="
  echo ""
}

install_addition_linux_packages() {
  echo "=== Starting additional packages install ==="
 
    sudo apt install -y \
      nfs-common \
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
  sudo apt update
  sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

  sudo apt-cache policy docker-ce

  sudo apt install docker-ce
}

install_nvm() {
  echo "=== Starting doom emacs install ==="

  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

  echo ""
  echo "=== Done ==="
  echo ""
}

# Install 1password cli so that we can download ssh keys
install_onepassword() {
  # NOTE: This is copied straight from here: https://developer.1password.com/docs/cli/get-started#install

  curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg

  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" |
  sudo tee /etc/apt/sources.list.d/1password.list

  sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
  curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
  sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
  sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
  curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
  sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg

  sudo apt update && sudo apt install 1password-cli

  op --version
}

# Use 1password to fetch ssh keys and put in the correct place
download_ssh_keys() {
  # NOTE: !!!!! https://1password.community/discussion/128054/how-to-export-ssh-private-key-using-cli
  #       Currently an issue with the way that op downloads the key files. This is being looked at but is currently not working
  #       Have manually moved the keys for now

  # Create a temp dir for exporting keys
  echo "=== Creating tmp dir for keys ==="
  mkdir -p ~/tmp

  # Make sure we have a session token
  echo "=== Login in to 1password ==="
  eval $(op signin)

  # Create a temp key. This is a hacky way of making sure that the ~/.ssh/ dir exists and has the correct permissions
  echo "=== Creating a temp ssh key ==="
  ssh-keygen -q -t rsa -N '' -f ~/.ssh/temp_id_rsa <<<y >/dev/null 2>&1

  echo "=== Current ssh keys ==="
  ls -las ~/.ssh/

  echo "=== Downloading keys from 1password ==="
  # Personal keys
  op read op://homelab/ben_personal/'private key' >> ~/tmp/ben_personal_id_25519
  op read op://homelab/ben_personal/'public key' >> ~/tmp/ben_personal_id_25519.pub

  # Github deploy keys
  op read op://homelab/github_deploy_key/'private key' >> ~/tmp/gh_deploy_id_25519
  op read op://homelab/github_deploy_key/'public key' >> ~/tmp/gh_deploy_id_25519.pub
  ls -las ~/tmp

  echo "=== Moving keys into the correct dir ==="
  cp ~/tmp/ben_personal_id_25519 ~/.ssh/
  cp ~/tmp/ben_personal_id_25519.pub ~/.ssh/

  cp ~/tmp/gh_deploy_id_25519 ~/.ssh/
  cp ~/tmp/gh_deploy_id_25519.pub ~/.ssh/

  echo "=== Setting permission of ssh keys ==="
  chmod 600 ~/.ssh/ben_personal_id_25519.pub
  chmod 600 ~/.ssh/gh_deploy_id_25519.pub
  chmod 600 ~/.ssh/ben_personal_id_25519
  chmod 600 ~/.ssh/gh_deploy_id_25519

  echo "=== Cleaning up temp items ==="
  rm -rf ~/tmp
  rm -f ~/.ssh/temp_id_rsa.pub
  rm -f ~/.ssh/temp_id_rsa

  ls -las ~/.ssh/
}
