  { config, pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;
with import <home-manager/modules/lib/dag.nix> { inherit lib; };

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    packages = with pkgs; [
      python38Packages.ansible
      pkgs.nyxt
      emacs-all-the-icons-fonts
    ];
  };
}
