{ config, lib, pkgs, ... }:

with import <nixpkgs> { };

{
  home = { packages = with pkgs; [ mu isync ]; };

  programs = {

    git = {
      enable = true;
      userName = "Ben Harvey";
      userEmail = "ben@harvey.onl";
      includes = [
        {
          condition = "gitdir:~/Workspace/github.com/BenDHarvey/**";
          contents = {
            user.email = "ben@harvey.onl";
            user.name = "Ben Harvey";
          };
        }
        {
          condition = "gitdir:~/Workspace/github.com/BMLOnline/**";
          contents = {
            user.email = "benh@bodymindlife.online";
            user.name = "Ben Harvey";
          };
        }
      ];
    };
  };
}
