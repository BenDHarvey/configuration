{ config, lib, pkgs, ... }:

with lib;
with import <nixpkgs> { };

{
  programs = {
    rofi = {
      enable = true;
    };
  };
}
