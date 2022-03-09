{ config, lib, pkgs, ... }:

{
  home = {
    # Install the needed emacs packages
    packages = with pkgs; [
      neovim
    ];

    # Link doom config files to the correct location
    file.".vimrc".source = ../../dotfiles/vimrc;
  };
}
