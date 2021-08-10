{ pkgs, lib, config, ... }:

let home           = builtins.getEnv "HOME";
    tmpdir         = "/tmp";

    xdg_configHome = "${home}/.config";
    xdg_dataHome   = "${home}/.local/share";
    xdg_cacheHome  = "${home}/.cache";
    config_home  = "${home}/.configuration";

in {
  imports = [ <home-manager/nix-darwin> ];

  services = {
    nix-daemon.enable = false;
    activate-system.enable = true;
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

#  services.yabai = {
#    enable = true;
#    package = pkgs.yabai;
#    config = {
#      mouse_follows_focus = "off";
#      focus_follows_mouse = "off";
#      window_placement = "second_child";
#      window_topmost = "off";
#      window_opacity = "off";
#      window_opacity_duration = 0.0;
#      window_shadow = "on";
#      window_border = "off";
#      window_border_placement = "inset";
#      window_border_width = 4;
#      window_border_radius = -1.0;
#      active_window_border_topmost = "off";
#      active_window_border_color = "0xff775759";
#      normal_window_border_color = "0xff505050";
#      insert_window_border_color = "0xffd75f5f";
#      active_window_opacity = 1.0;
#      normal_window_opacity = 0.9;
#      split_ratio = 0.5;
#      auto_balance = "on";
#      mouse_modifier = "fn";
#      mouse_action1 = "move";
#      mouse_action2 = "resize";
#      layout = "bsp";
#      top_padding = 5;
#      bottom_padding = 5;
#      left_padding = 5;
#      right_padding = 5;
#      window_gap = 5;
#    };
#  };
#
#  services.skhd = {
#    enable = true;
#    package = pkgs.skhd;
#    skhdConfig = builtins.readFile "${config_home}/dotfiles/skhdrc";
#  };
}
