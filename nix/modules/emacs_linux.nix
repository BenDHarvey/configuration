{ config, lib, pkgs, ... }:

{
  services.emacs.enable = true;
  programs.emacs.enable = true;

  home = {

    # Install the needed emacs packages
    packages = with pkgs; [
      emacs-all-the-icons-fonts
      #emacs27Packages.pdf-tools
    ];

    # Link doom config files to the correct location
    file.".doom.d".source = ../../dotfiles/doom.d;
  };

  # Got this nice little snippet from here https://github.com/little-dude/dotfiles/blob/master/programs/emacs/default.nix#L109
  xdg.dataFile."applications/emacsclient.desktop".text = ''
    [Desktop Entry]
    Name=Emacsclient
    GenericName=Text Editor
    Comment=Edit text
    MimeType=text/english;text/plain;text/x-makefile;text/x-c++hdr;text/x-c++src;text/x-chdr;text/x-csrc;text/x-java;text/x-moc;text/x-pascal;text/x-tcl;text/x-tex;application/x-shellscript;text/x-c;text/x-c++;
    Exec=emacsclient -c -a emacs %F
    Icon=emacs
    Type=Application
    Terminal=false
    Categories=Development;TextEditor;
    StartupWMClass=Emacs
    Keywords=Text;Editor;
  '';
}
