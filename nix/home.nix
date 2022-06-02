{ config, pkgs, ... }:

with builtins;
with lib;

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./modules/zsh.nix
    ./modules/common_packages.nix
    ./modules/common_dotfiles.nix
    ./modules/linux_packages.nix
    ./modules/emacs_linux.nix
    ./modules/secrets.nix
    ./modules/neovim.nix
    ./modules/git.nix
    ./modules/tmux_linux.nix
    ./modules/nodes.nix
    ./modules/mail.nix
    ./modules/i3-gaps.nix
    ./modules/rofi.nix
    ./modules/alacritty.nix
    ./modules/go.nix
  ];

  home = {
    username = "ben";
    homeDirectory = "/home/ben";

    sessionVariables = { EDITOR = "emacs -nw"; };

    file."./.ssh/config".source = ../dotfiles/ssh_config;
  };

  programs = {
    zoxide.enable = true;

    fzf = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };

  # Store mails in ~/Mail
  accounts.email.maildirBasePath = "Mail";

  home.stateVersion = "20.09";
}
