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
  };

  ## Need to keep this. nix-darwin seems to be missing from the path if it is removed
  programs = {
    zsh.enable = true;
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

      finder = {
        AppleShowAllExtensions = true;
      };
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
  };

  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
  ];

  # Prefer installing application from the Mac App Store
  #
  # Commented apps suffer continual update issue:
  # https://github.com/malob/nixpkgs/issues/9
  homebrew.masApps = {
    "1Password" = 1333542190;
    "Dark Mode for Safari" = 1397180934;
    Numbers = 409203825;
    Pages = 409201541;
    Slack = 803453959;
    Vimari = 1480933944;
    Xcode = 497799835;
  };

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
    "transmit"
    "visual-studio-code"
    "vlc"
  ];

  # Configuration related to casks
#  environment.variables.SSH_AUTH_SOCK = mkIfCaskPresent "secretive"
#     "/Users/${config.users.primaryUser}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";

  # For cli packages that aren't currently available for macOS in `nixpkgs`.Packages should be
  # installed in `../home/default.nix` whenever possible.
#  homebrew.brews = [
#    "swift-format"
#    "swiftlint"
#  ];
}
