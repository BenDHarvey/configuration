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

  home = {
    username = "ben";
    homeDirectory = "/Users/ben";
    sessionVariables = {
      EDITOR = "emacs";
    };

    packages = [
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
      pkgs.docker-compose
      pkgs.ranger
      pkgs.tree
      pkgs.reattach-to-user-namespace
      pkgs.cocoapods
      pkgs.rsync
      pkgs.hugo
      pkgs.argocd
      pkgs.neovim
      pkgs.gh
      pkgs.act
      pkgs.yq
      pkgs.unixtools.watch
      pkgs.sops
      pkgs.k9s
      pkgs.kubernetes-helm
      pkgs.influxdb2
      #Mail packages
      pkgs.mu
      pkgs.isync
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
      # TODO: Packages that are having issues and need to be looked at
      # pkgs.nyxt # likely an m1 arch issue
      # pkgs.kitty # likely an m1 arch issue
      # pkgs.yabai # likely an m1 arch issue
    ];

    file.".emacs.d/init.el".text = ''
        (load "default.el")
    '';
    file.".vimrc".source = ../dotfiles/vimrc;
    file.".gitconfig".source = ../dotfiles/gitconfig;
    file.".gitconfig-ben".source = ../dotfiles/gitconfig-ben;
    file.".gitconfig-bmlonline".source = ../dotfiles/gitconfig-bmlonline;
    file.".tmux.conf".source = ../dotfiles/tmux.conf;
    file.".authinfo.gpg".source = ../dotfiles/authinfo.gpg;
  };

  programs = {
    go = {
      enable = true;
    };

    msmtp = {
      enable = true;
    };

    mbsync = {
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

    zsh = {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      enableAutosuggestions = true;
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
          docker volume prune -f
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

        ## zsh-vim-mode config
        ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
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
        {
          name = "zsh-vi-mode";
          src = fetchFromGitHub {
            owner = "jeffreytse";
            repo = "zsh-vi-mode";
            rev = "5eb9c43f941a3ac419584a5c390aeedf4916b245";
            sha256 = null;
          };
          file = "zsh-vi-mode.zsh";
        }
      ];
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    gpg = {
      enable = true;
      settings = {
        default-key = "EB4C80B64D5FBF255C5F4633518A2E5A77959839";

        auto-key-locate = "keyserver";
        keyserver = "hkps://hkps.pool.sks-keyservers.net";
        keyserver-options = "no-honor-keyserver-url include-revoked auto-key-retrieve";
      };
    };
  };

  # Store mails in ~/Mail
  accounts.email.maildirBasePath = "Mail";

  home.stateVersion = "20.09";
}
