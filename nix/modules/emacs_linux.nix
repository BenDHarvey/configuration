{ config, lib, pkgs, ... }:

{
  home = {
    services.emacs.enable = true;

    # Install the needed emacs packages
    packages = with pkgs; [
      emacs
      emacs-all-the-icons-fonts
      #emacs27Packages.pdf-tools
    ];

    # Link doom config files to the correct location
    file.".doom.d".source = ../../dotfiles/doom.d;
  };
}
