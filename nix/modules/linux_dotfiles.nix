# Misc dotfiles that did not fit into any of the other modules
{ config, lib, pkgs, ... }:

{
  home = {
    file."./.ssh/config".source = ../../dotfiles/ssh_config;
  };
}
