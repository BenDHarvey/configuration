# This came from here... https://github.com/malob/nixpkgs still needs some work to get it running
{ config, lib, ... }:

let
  mkIfCaskPresent = cask: lib.mkIf (lib.any (x: x == cask) config.homebrew.casks);
in

{
  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;
  homebrew.brewPrefix= "/opt/homebrew/bin";

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
  ];

  homebrew.masApps = {
    "1Password" = 1333542190;
    Numbers = 409203825;
    Pages = 409201541;
    Slack = 803453959;
    Vimari = 1480933944;
    Telegram = 747648890;
    Magnet = 441258766;
    GoodNotes = 1444383602;
  };

  homebrew.brews = [
  ];

  homebrew.casks = [
    "vlc"
    "visual-studio-code"
    "notion"
    "postman"
    "google-cloud-sdk"
    "ledger-live"
    "caffeine"
    "alacritty"
    "dbeaver-community"
  ];
}