{ config, pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;
with import <home-manager/modules/lib/dag.nix> { inherit lib; };

let
  settings = import ./config;
in {
  imports = [
    ./shared/home.nix
    ./linux/home.nix
  ];
}
