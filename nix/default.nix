{ pkgs ? import <nixpkgs> {
    config = { allowUnfree = true; };
  }
}:

{
  home = pkgs.callPackage ./modules/home { };
}
