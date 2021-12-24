  { config, pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;

{
  home = {
    packages = with pkgs; [
      python38Packages.ansible
      pkgs.nyxt

      # desktop
      arandr
      chromium
      discord
      evince
      feh
      libnotify
      pavucontrol
      slack
      spotify
      tdesktop
      virtmanager
      vlc
      networkmanagerapplet

      # i3
      acpi
      i3lock-fancy
      i3status-rust
    ];

    file."./i3/config".source = ./files/i3_config;
    file.".config/i3/bar".source = ./i3_status_rs.toml";

    services.screen-locker = {
      enable = true;
      lockCmd = "\${pkgs.i3lock-fancy}/bin/i3lock-fancy";
    };

    services.unclutter.enable = true;
  };
}
