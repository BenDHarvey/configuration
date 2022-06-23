{ config, lib, pkgs, ... }:

{
  home = {
    # Install the needed emacs packages
    packages = with pkgs; [
      # Node and node packages
      nodejs-16_x
      nodePackages.typescript
      nodePackages.eslint
      nodePackages.prettier
      nodePackages.typescript-language-server
      nodePackages.js-beautify
      nodePackages.lerna
      nodePackages.prisma
      yarn
    ];

    # Link doom config files to the correct location
    file.".doom.d".source = ../../dotfiles/doom.d;
  };
}
