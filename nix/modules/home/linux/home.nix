  { config, pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;
with import <home-manager/modules/lib/dag.nix> { inherit lib; };

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
  };

  services.dunst = {
    enable = true;
    settings = {
      global = {
        allow_markup = true;
        alignment = "left";
        bounce_freq = 0;
        font = "Iosevka Nerd Font 10";
        format = "<b>%s</b>\\n%p %b";
        frame_width = 2;
        geometry = "300x5-30+50";
        horizontal_padding = 4;
        idle_threshold = 20;
        ignore_newline = false;
        indicate_hidden = true;
        padding = 4;
        separator_color = "auto";
        separator_height = 2;
        show_age_threshold = 60;
        sort = true;
        word_wrap = true;
      };

      urgency_low = {
        background = "#1a1a1a";
        foreground = "#b8b8b8";
        frame_color = "#3d99ba";
        timeout = 10;
      };

      urgency_normal = {
        background = "#1a1a1a";
        foreground = "#b8b8b8";
        frame_color = "#015b82";
        timeout = 10;
      };

      urgency_critical = {
        background = "#1a1a1a";
        foreground = "#b8b8b8";
        frame_color = "#9e0000";
        timeout = 0;
      };
    };
  };

  home.file."./i3/config".source = ./files/i3_config;
  home.file.".config/i3/bar".source = ./i3_status_rs.toml";
}
