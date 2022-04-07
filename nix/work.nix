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
    ./modules/mac_tmux.nix
    ./modules/nodes.nix
    ./modules/kitty.nix
    ./modules/dotfiles.nix
    ./modules/mail.nix
#    ./modules/work/rqp.nix
  ];

  home = {
    username = "ben.harvey";
    homeDirectory = "/Users/ben.harvey";

    sessionVariables = { EDITOR = "emacs -nw"; };
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
