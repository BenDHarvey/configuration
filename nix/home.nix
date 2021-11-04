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
      EDITOR = "emacs -nw";
    };

    packages = with pkgs; [
      tmux
      git
      xclip
      jq
      wget
      zsh
      ripgrep
      fd
      htop
      terraform
      awscli
      docker-compose
      ranger
      tree
      reattach-to-user-namespace
      cocoapods
      rsync
      hugo
      argocd
      neovim
      gh
      act
      yq
      unixtools.watch
      sops
      k9s
      kubernetes-helm
      influxdb2
      coreutils
      clang
      cmake

      #Mail packages
      mu
      isync
      # go and golang packages
      gopls
      gore
      gocode
      gotests
      gomodifytags
      # Kinda go packages
      protobuf
      protoc-gen-go
      # Node and node packages
      nodejs-16_x
      nodePackages.typescript
      nodePackages.eslint
      nodePackages.prettier
      nodePackages.typescript-language-server
      nodePackages.js-beautify
      # emacs and other emacs things
      doom-emacs # This will install emacs as well
      # Python packages
      python38Packages.ansible
      # TODO: Packages that are having issues and need to be looked at
      # pkgs.nyxt # likely an m1 arch issue
      # pkgs.kitty # likely an m1 arch issue
      emacs-all-the-icons-fonts
    ];

    file.".emacs.d/init.el".text = ''
        (load "default.el")
    '';
    file.".vimrc".source = ../dotfiles/vimrc;
    file.".gitconfig".source = ../dotfiles/gitconfig;
    file.".gitconfig-ben".source = ../dotfiles/gitconfig-ben;
    file.".gitconfig-bmlonline".source = ../dotfiles/gitconfig-bmlonline;
    file.".authinfo.gpg".source = ../dotfiles/authinfo.gpg;
  };


  programs = {
    zoxide.enable = true;

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

        # Nix aliases
        nixre="darwin-rebuild switch";
        nixrb="darwin-rebuild --rollback";
        nixgc="nix-collect-garbage -d";
        nixq="nix-env -qaP";
        nixupgrade-darwin="sudo -i sh -c 'nix-channel --update && nix-env -iA nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'";
        nixup="nix-env -u";
      };

      profileExtra = ''
        export GPG_TTY=$(tty)
        if ! pgrep -x "gpg-agent" > /dev/null; then
            ${pkgs.gnupg}/bin/gpgconf --launch gpg-agent
        fi

        export PATH=/opt/homebrew/bin:$PATH
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
        ## Allow fzf to still work with vi-mode
        # Define an init function and append to zvm_after_init_commands
        function vi_mode_init() {
          [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
        }
        zvm_after_init_commands+=(vi_mode_init)

        eval "$(zoxide init zsh)"
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

    git = {
      enable = true;
      userName = "Ben Harvey";
      userEmail = "ben@harvey.onl";
      includes = [{
        condition = "gitdir:~/Workspace/github.com/BenDHarvey/**";
        contents = {
          user.email = "ben@harvey.onl";
          user.name = "Ben Harvey";
        };
      }
      {
        condition = "gitdir:~/Workspace/github.com/BMLOnline/**";
        contents = {
          user.email = "benh@bodymindlife.online";
          user.name = "Ben Harvey";
        };
      }];
    };

    tmux = {
        enable = true;
        tmuxp.enable = true;
        historyLimit = 500000;
        extraConfig = ''
          unbind C-b
          set -g prefix `
          bind-key ` send-prefix

          setw -g mouse on
          setw -g mode-keys vi

          set -g @scroll-speed-num-lines-per-scroll 1

          set -g status-interval 60
          set -g status off
          setw -g monitor-activity off
          set -g visual-activity on
          #
          ## Quick window selection
          bind -r C-h select-window -t :-
          bind -r C-l select-window -t :+
          bind -r C-s set -g status
          #
          set-option -ga terminal-overrides ",xterm-256color:Tc"
          #set-option -g default-shell /usr/bin/zsh
          ## Default terminal is 256 colors
          set -g default-terminal "screen-256color"
          ## This option has issues when running in linux
          set-option -g default-command "reattach-to-user-namespace -l zsh"
          #
          unbind c
          unbind '"'
          unbind %
          bind '"' split-window -c "#{pane_current_path}"
          bind % split-window -h -c "#{pane_current_path}"
          bind c new-window -c "#{pane_current_path}"
          bind h select-pane -L
          bind j select-pane -D
          bind k select-pane -U
          bind l select-pane -R
          #
          bind -r H resize-pane -L 5
          bind -r J resize-pane -D 5
          bind -r K resize-pane -U 5
          bind -r L resize-pane -R 5
          #
          set -g @plugin 'tmux-plugins/tpm'
          set -g @plugin 'nhdaly/tmux-better-mouse-mode'
          set -g @plugin 'tmux-plugins/tmux-sensible'
          set -g @plugin 'tmux-plugins/tmux-yank'
          #
          run '~/.tmux/plugins/tpm/tpm'
          #
        '';
      };
  };

  # Store mails in ~/Mail
  accounts.email.maildirBasePath = "Mail";

  home.stateVersion = "20.09";
}
