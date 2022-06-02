{ config, lib, pkgs, ... }:

{
  home = {
    # Link doom config files to the correct location
    file.".config/i3/config".source = ../../dotfiles/config/i3/config;
    file.".config/yabar/yabar.conf".source = ../../dotfiles/yabar/yabar.conf;
  };
}
