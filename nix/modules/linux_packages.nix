{ config, lib, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      zoom-us
      slack
      postman
      kitty
      pinentry
      discord
      kube3d
      ansible
    ];
  };
}
