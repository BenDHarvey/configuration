{ config, lib, pkgs, ... }:

{
  home = {
    file.".gitconfig".source = ../../dotfiles/gitconfig;
    file.".gitconfig-ben".source = ../../dotfiles/gitconfig-ben;
    file.".gitconfig-nibgroup".source = ../../dotfiles/gitconfig-nibgroup;
  };
}
