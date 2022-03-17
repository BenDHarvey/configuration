# This came from here... https://github.com/malob/nixpkgs still needs some work to get it running
{ config, lib, ... }:

let
  mkIfCaskPresent = cask:
    lib.mkIf (lib.any (x: x == cask) config.homebrew.casks);

in {
  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;
  homebrew.brewPrefix = "/opt/homebrew/bin";

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
    "d12frosted/emacs-plus"
  ];

  homebrew.masApps = {
    "1Password" = 1333542190;
    Slack = 803453959;
    Vimari = 1480933944;
    Telegram = 747648890;
    Magnet = 441258766;
  };

  homebrew.casks = [
    "vlc"
    "postman"
    "alacritty"
    "miro"
    "ledger-live"
    "caffeine"
    "gpg-suite-pinentry"
  ];

  homebrew.brews = [
    "nvm"
    "podman"
    "k3d"
    "pkg-config" # This is to get the node-canvas npm package running
    "cairo" # This is to get the node-canvas npm package running
    "pango" # This is to get the node-canvas npm package running
    "libpng" # This is to get the node-canvas npm package running
    "jpeg" # This is to get the node-canvas npm package running
    "giflib" # This is to get the node-canvas npm package running
    "librsvg" # This is to get the node-canvas npm package running
  ];
}
