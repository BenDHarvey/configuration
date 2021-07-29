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
    doom-emacs # This will install emacs as well
  ];

  # Load the emacs package
  home.file.".emacs.d/init.el".text = ''
      (load "default.el")
  '';

  # Link some common files from the dotfiles directory
  home.file.".vimrc".source = ../dotfiles/vimrc;
  home.file.".gitconfig".source = ../dotfiles/gitconfig;
  home.file.".gitconfig-ben".source = ../dotfiles/gitconfig-ben;
  home.file.".gitconfig-switchdin".source = ../dotfiles/gitconfig-switchdin;
  home.file.".tmux.conf".source = ../dotfiles/tmux.conf;


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
