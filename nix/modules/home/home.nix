  { config, pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;
with import <home-manager/modules/lib/dag.nix> { inherit lib; };

{
  imports = [
    <home-manager/nix-darwin>
    ./homebrew/homebrew.nix
  ];
}
