{ config, pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [ ./zsh.nix, ./mail.nix ];

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
      ripgrep
      fd
      htop
      terraform
      awscli
      docker-compose
      ranger
      tree
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
      ffmpeg
      vagrant
      nmap
      
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
      python38Packages.ansible
      emacs-all-the-icons-fonts
      emacs
      radeontop
    ];

    file.".emacs.d/init.el".text = ''
        (load "default.el")
    '';
    file.".vimrc".source = ../../../../dotfiles/vimrc;
    file.".gitconfig".source = ../../../../dotfiles/gitconfig;
    file.".gitconfig-ben".source = ../../../../dotfiles/gitconfig-ben;
    file.".gitconfig-bmlonline".source = ../../../../dotfiles/gitconfig-bmlonline;
    file.".authinfo.gpg".source = ../../../../dotfiles/authinfo.gpg;
    file.".snippets".source = ../../../../dotfiles/doom.d/snippets;
  };

  programs = {
    alacritty = {
      enable = true;
      settings = {
        font.size = 12;
        normal = {
          family = "Iosevka Nerd Font";
          style = "Regular";
        };
        mouse.hide_when_typing = true;
      };
    };

    zoxide.enable = true;

    go = {
      enable = true;
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
