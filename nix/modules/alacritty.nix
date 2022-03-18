{ config, lib, pkgs, ... }:

{
  programs = {
    alacritty = {
      enable = true;
      settings = {
        font.size = 11;
        normal = {
          family = "Iosevka Nerd Font";
          style = "Regular";
        };
        mouse.hide_when_typing = true;
        shell.program = "/home/ben/.nix-profile/bin/zsh";
      };
    };
  };
}
