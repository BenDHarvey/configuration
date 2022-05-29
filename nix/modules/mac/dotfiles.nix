# Misc dotfiles that did not fit into any of the other modules
{ config, lib, pkgs, ... }:

{
  home = {
    file.".yabairc".source = ../../dotfiles/yabirc;
    file.".skhdrc".source = ../../dotfiles/skhdrc;
  };
}
