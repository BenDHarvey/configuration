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
    ./modules/homebrew.nix # Note: This should be required in the darwin config and not in home-manager config
  ];

  services = {
    nix-daemon.enable = true;
    activate-system.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      chromium = { enableWideVine = true; };
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball
          "https://github.com/nix-community/NUR/archive/master.tar.gz") {
            inherit pkgs;
          };
      };
      permittedInsecurePackages = [ "openssl-1.0.2u" ];
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
