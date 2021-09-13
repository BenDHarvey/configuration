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
#          ./homebrew.nix
  ];

  services = {
    nix-daemon.enable = false;
    activate-system.enable = true;
    emacs.enable = true;
  };

  programs = {
    zsh.enable = true;
  };

  users = {
    users.ben = {
      name = "ben";
      home = "/Users/ben";
      shell = pkgs.zsh;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    users.ben = "${home}/.config/nixpkgs/home.nix";
  };

  system = {
    stateVersion = 4;

    defaults = {
      dock = {
        autohide = true;
        launchanim = false;
        orientation = "right";
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };
}
