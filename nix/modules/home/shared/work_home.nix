{ config, pkgs, ... }:

with import <nixpkgs> { };
with builtins;
with lib;

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./zsh.nix
    #./mail.nix
    #./firefox.nix
    #./git.nix
    #./alacritty.nix
    #./vscode.nix
  ];

  home = {
    username = "ben.harvey";
    homeDirectory = "/Users/ben.harvey";
    
    sessionVariables = { EDITOR = "emacs -nw"; };

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
      neovim
      gh
      act
      yq
      unixtools.watch
      sops
      k9s
      kubernetes-helm
      coreutils
      clang
      cmake
      ffmpeg
      nmap
      fluxcd
      tmuxinator
      neovim
      postgresql

      # go and golang packages
      gopls
      gore
      gocode
      gotests
      gomodifytags
      go-migrate

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
      yarn

      python38Packages.ansible

      # Emacs and emacs packages
      emacs-all-the-icons-fonts
      emacs
      emacs27Packages.pdf-tools

      sentry-cli
      pulumi-bin
      google-cloud-sdk
      kubectl
    ];

    file.".vimrc".source = ../../../../dotfiles/vimrc;
    file.".gitconfig".source = ../../../../dotfiles/gitconfig;
    file.".gitconfig-ben".source = ../../../../dotfiles/gitconfig-ben;
    file.".gitconfig-bmlonline".source =
      ../../../../dotfiles/gitconfig-bmlonline;
    file.".authinfo.gpg".source = ../../../../dotfiles/authinfo.gpg;
    file.".doom.d".source = ../../../../dotfiles/doom.d;
    file."./.ssh/config".source = ../../../../dotfiles/ssh_config;
  };

  programs = {
    go = { enable = true; };

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
        keyserver-options =
          "no-honor-keyserver-url include-revoked auto-key-retrieve";
      };
    };
  };

  # Store mails in ~/Mail
  accounts.email.maildirBasePath = "Mail";

  home.stateVersion = "20.09";
}
