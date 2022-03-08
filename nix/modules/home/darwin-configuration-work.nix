# Configuration for my work laptop
{ pkgs, lib, config, ... }:

let home           = builtins.getEnv "HOME";
    tmpdir         = "/tmp";

    xdg_configHome = "${home}/.config";
    xdg_dataHome   = "${home}/.local/share";
    xdg_cacheHome  = "${home}/.cache";
    config_home  = "${home}/.configuration";

in {
  imports = [
    <home-manager/nix-darwin>
  ];

  services = {
    nix-daemon.enable = true;
    activate-system.enable = true;
  };

  ## Need to keep this. nix-darwin seems to be missing from the path if it is removed
  programs = {
    zsh = {
      enable = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowInsecure = false;
      allowUnsupportedSystem = true;
    };
  };

  users = {
    users."ben.harvey" = {
      name = "ben.harvey";
      home = "/Users/ben.harvey";
      shell = pkgs.zsh;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    users."ben.harvey" = "${home}/.config/nixpkgs/home.nix";
  };

  system = {
    stateVersion = 4;

    defaults = {
      dock = {
        autohide = true;
        launchanim = false;
        orientation = "right";
      };

      finder = {
        AppleShowAllExtensions = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
}
