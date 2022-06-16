{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      postman
      kitty
      pinentry
      discord
      kube3d
      ansible
      vlc
      slack
      flameshot
      zoom-us
      yabar
      cmus
      rhythmbox
    ];
  };
}
