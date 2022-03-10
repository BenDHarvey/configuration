{ config, lib, pkgs, ... }:

{
  home = {
    # Install the needed emacs packages
    packages = with pkgs; [
      gopls
      gore
      gocode
      gotests
      gomodifytags
      go-migrate
    ];
  };

  programs = {
    go = { enable = true; };
  };
}
