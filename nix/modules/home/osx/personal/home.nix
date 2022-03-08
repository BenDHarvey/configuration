  { config, pkgs, ... }:

  with import <nixpkgs> { };
  with builtins;
  with lib;
  with import <home-manager/modules/lib/dag.nix> { inherit lib; };

  {
    imports = [
      <home-manager/nix-darwin>
      ../../shared/home.nix
      ./../homebrew.nix
      ./../tmux.nix
    ];

    home = { 
      username = "ben";
      homeDirectory = "/Users/ben";
      
      packages = with pkgs; [ reattach-to-user-namespace cocoapods ]; 
    };
  }
