{ config, lib, pkgs, ... }:

{
  home = {
    # Link doom config files to the correct location
    file.".config/i3/config".source = ../../dotfiles/config/i3/config;
    file.".config/yabar/yabar.conf".source = ../../dotfiles/yabar/yabar.conf;
    file.".config/i3lock/i3lock.sh".source = ../../dotfiles/config/i3lock/i3lock.sh;
    file.".config/i3/i3exit".source = ../../dotfiles/config/i3/i3exit;

    file.".config/wallpapers/lock_heihei.png".source = ../../dotfiles/config/wallpapers/wallpaper_heihei.png;
  };
}
