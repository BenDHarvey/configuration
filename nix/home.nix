  { config, pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;
with import <home-manager/modules/lib/dag.nix> { inherit lib; };

let
  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz;
  }) {
    doomPrivateDir = ../dotfiles/doom.d;  # Directory containing your config.el init.el
  };
in 

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ben";
  home.homeDirectory = "/Users/ben";

  # packages to install

  home.packages = [
    pkgs.tmux
    pkgs.git
    pkgs.xclip
    pkgs.jq
    pkgs.zsh
    pkgs.ripgrep
    pkgs.fd
    pkgs.htop
    pkgs.terraform
    pkgs.awscli
    # pkgs.iterm2 # TODO: Install this with homebrew instead
    pkgs.docker-compose
    pkgs.ranger
    pkgs.tree
    pkgs.reattach-to-user-namespace
    pkgs.cocoapods
    pkgs.rsync
    pkgs.hugo
    # pkgs.kube3d # Not yet working on arm systems
    pkgs.argocd
    pkgs.neovim
    # pkgs.kitty # TODO: Does compile with apple m1
    pkgs.gh

    #Mail packages
    pkgs.mu
    pkgs.isync

    pkgs.unixtools.watch
    pkgs.sops
    pkgs.k9s
    pkgs.kubernetes-helm
    pkgs.influxdb2

    # go and golang packages
    pkgs.gopls
    pkgs.gore
    pkgs.gocode
    pkgs.gotests
    pkgs.gomodifytags

    # Kinda go packages
    pkgs.protobuf
    pkgs.protoc-gen-go

    # Node and node packages
    pkgs.nodejs-16_x
    pkgs.nodePackages.typescript
    pkgs.nodePackages.eslint
    pkgs.nodePackages.prettier
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.js-beautify

    # emacs and other emacs things
    doom-emacs # This will install emacs as well

    # Python packages
    pkgs.python38Packages.ansible
  ];

  # Load the emacs package
  home.file.".emacs.d/init.el".text = ''
      (load "default.el")
  '';

  # Link some common files from the dotfiles directory
  home.file.".vimrc".source = ../dotfiles/vimrc;
  home.file.".gitconfig".source = ../dotfiles/gitconfig;
  home.file.".gitconfig-ben".source = ../dotfiles/gitconfig-ben;
  home.file.".gitconfig-bmlonline".source = ../dotfiles/gitconfig-bmlonline;
  home.file.".tmux.conf".source = ../dotfiles/tmux.conf;

  programs.go = {
    enable = true;
  };

  # Mail configuration
  programs.msmtp.enable = true;

  # Store mails in ~/Mail
  accounts.email.maildirBasePath = "Mail";

  # Use mbsync to fetch email. Configuration is constructed manually
  # to keep my current email layout.
  programs.mbsync = {
    enable = true;
    extraConfig = lib.mkBefore ''
      MaildirStore ben@harvey.onl-local
      Path ~/Mail/ben@harvey.onl/
      Inbox ~/Mail/ben@harvey.onl/Inbox
      Trash Trash
      SubFolders Verbatim

      IMAPStore ben@harvey.onl-remote
      Host imap.fastmail.com
      Port 993
      User ben@harvey.onl
      PassCmd "sops -d --extract '[\"benHarveyOnl_fastmail\"][\"password\"]' ~/.configuration/secrets/mail.yaml"
      SSLType IMAPS
      SSLVersions TLSv1.2

      Channel ben@harvey.onl
      Master :ben@harvey.onl-remote:
      Slave :ben@harvey.onl-local:
      Patterns *
      Expunge None
      CopyArrivalDate yes
      Sync All
      Create Slave
      SyncState *
    '';
  };

  # ZSH config
  programs.zsh = {
    enable = true;
    autocd = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = false;
    enableCompletion = true;
    shellAliases = {
      ls = "ls -las";
      emacs = "emacs -nw";
      gs = "git status";
      gl = "git log --decorate --graph";
      gd = "git diff";
      vim = "nvim";
      cl = "clear";
    };

    profileExtra = ''
      export GPG_TTY=$(tty)
      if ! pgrep -x "gpg-agent" > /dev/null; then
          ${pkgs.gnupg}/bin/gpgconf --launch gpg-agent
      fi
    '';

    initExtra = ''
      bindkey '^ ' autosuggest-accept
      AGKOZAK_CMD_EXEC_TIME=5
      AGKOZAK_COLORS_CMD_EXEC_TIME='yellow'
      AGKOZAK_COLORS_PROMPT_CHAR='magenta'
      AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' )
      AGKOZAK_MULTILINE=0
      AGKOZAK_PROMPT_CHAR=( ❯ ❯ ❮ )
      autopair-init

      if [ -e /Users/ben/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/ben/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

      # Extra functions

      dockerNuke() {
        docker stop $(docker ps -a -q)
        docker system prune -a -f
        docker volume prune
      }

      postgresUp() {
        docker run --name switchdin-postgres \
          -e POSTGRES_PASSWORD=postgres \
          -e POSTGRES_USER=postgres \
          -e POSTGRES_DB=switchdin \
          -p "5432:5432" \
          -d postgres
      }

      # Removes node_modules folder and package-lock.json reinstalls node_modules
      node-reinstall() {
        echo "Removing node_modules...."
        sudo rm -r node_modules
        echo "Removing package-lock.json"
        sudo rm package-lock.json
        echo "Installing node_modules"
        npm i
      }

      jwtDecode () {
        sed 's/\./\n/g' <<< $(cut -d. -f1,2 <<< $1) | base64 --decode | jq
      }

      clean-repo() {
        git clean -xfd
        git submodule foreach --recursive git clean -xfd
        git reset --hard
        git submodule foreach --recursive git reset --hard
        git submodule update --init --recursive
      }

      git-contributors() {
        git shortlog --summary --numbered --email
      }

      function killByPort {
        if [ "$1" != "" ]
        then
          kill -9 $(lsof -ni tcp:"$1" | awk 'FNR==2{print $2}')
        else
          echo "Missing argument! Usage: kill-by-port $PORT"
        fi
      }

     '';

    plugins = with pkgs; [
      {
        name = "agkozak-zsh-prompt";
        src = fetchFromGitHub {
          owner = "agkozak";
          repo = "agkozak-zsh-prompt";
          rev = "v3.7.0";
          sha256 = "1iz4l8777i52gfynzpf6yybrmics8g4i3f1xs3rqsr40bb89igrs";
        };
        file = "agkozak-zsh-prompt.plugin.zsh";
      }
      {
        name = "formarks";
        src = fetchFromGitHub {
          owner = "wfxr";
          repo = "formarks";
          rev = "8abce138218a8e6acd3c8ad2dd52550198625944";
          sha256 = "1wr4ypv2b6a2w9qsia29mb36xf98zjzhp3bq4ix6r3cmra3xij90";
        };
        file = "formarks.plugin.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.6.0";
          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
      {
        name = "zsh-abbrev-alias";
        src = fetchFromGitHub {
          owner = "momo-lab";
          repo = "zsh-abbrev-alias";
          rev = "637f0b2dda6d392bf710190ee472a48a20766c07";
          sha256 = "16saanmwpp634yc8jfdxig0ivm1gvcgpif937gbdxf0csc6vh47k";
        };
        file = "abbrev-alias.plugin.zsh";
      }
      {
        name = "zsh-autopair";
        src = fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "34a8bca0c18fcf3ab1561caef9790abffc1d3d49";
          sha256 = "1h0vm2dgrmb8i2pvsgis3lshc5b0ad846836m62y8h3rdb3zmpy1";
        };
        file = "autopair.zsh";
      }
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.gpg = {
    enable = true;
    settings = {
      default-key = "EB4C80B64D5FBF255C5F4633518A2E5A77959839";

      auto-key-locate = "keyserver";
      keyserver = "hkps://hkps.pool.sks-keyservers.net";
      keyserver-options = "no-honor-keyserver-url include-revoked auto-key-retrieve";
    };
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
