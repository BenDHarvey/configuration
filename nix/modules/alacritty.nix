{ config, lib, pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font.size = 12;
        normal = {
          family = "Iosevka Nerd Font";
          style = "Regular";
        };
        mouse.hide_when_typing = true;
        shell.program = "/Users/ben.harvey/.nix-profile/bin/zsh";
      };
    };
  };
}
