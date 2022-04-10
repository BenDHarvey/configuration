{ config, pkgs, ... }:

with builtins;
with lib;

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./modules/zsh.nix
    ./modules/common_packages.nix
    ./modules/emacs.nix
    ./modules/secrets.nix
    ./modules/neovim.nix
    ./modules/git.nix
#    ./modules/tmux.nix
    ./modules/nodes.nix
    ./modules/kitty.nix
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
