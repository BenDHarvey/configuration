{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    texlive.combined.scheme-full

    # i3
    acpi
    i3lock-fancy
    i3status-rust

    # desktop
    arandr
    chromium
    libnotify
    pavucontrol
    slack
    tdesktop
    virtmanager
    vlc
    networkmanagerapplet

    # Emacs dependencies
    aspell
    aspellDicts.en
    aspellDicts.en-computers
    ccls
    editorconfig-core-c
    nixfmt
    shellcheck
  ];

  programs.bat = {
    enable = true;
    config = { tabs = "8"; };
  };

  programs.direnv = { enable = true; };

  programs.emacs.enable = true;

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

  services.screen-locker = {
    enable = true;
    lockCmd = "\${pkgs.i3lock-fancy}/bin/i3lock-fancy";
  };

  services.unclutter.enable = true;

  home.file.".config/i3/config".source = ./i3/i3_config;
  #home.file.".config/i3/bar".source = ./i3/i3_status_rs
  #  + ".${settings.flavour}.toml";
}
