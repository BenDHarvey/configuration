{ pkgs ? import <nixpkgs> {
    config = { allowUnfree = true; };
  }
}:

{
  home = pkgs.callPackage /home/ben/.configuration/nix/modules/home { };
}
