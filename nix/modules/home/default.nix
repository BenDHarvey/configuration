{ pkgs }:

{
  imports = [
    <home-manager>
    ./home.nix
  ];

  # Allow nix to recurse into this attribute set to look for derivations
  #recurseForDerivations = true;
}