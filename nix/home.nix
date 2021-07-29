{ config, pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;
with import <home-manager/modules/lib/dag.nix> { inherit lib; };

let
  doom-emacs = pkgs.callPackage (builtins.fetchTarball {
    url = https://github.com/vlaci/nix-doom-emacs/archive/master.tar.gz;
  }) {
    doomPrivateDir = ../dotfiles/doom.d;  # Directory containing your config.el init.el
  };
in 

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "ben";
  home.homeDirectory = "/Users/ben";

  # packages to install
  home.packages = [
    pkgs.tmux
    pkgs.git
    pkgs.xclip
    pkgs.jq
    pkgs.zsh
    pkgs.ripgrep
    pkgs.fd
    pkgs.htop
    pkgs.terraform
    pkgs.awscli
    # pkgs.iterm2 # TODO: Install this with homebrew instead
    pkgs.docker-compose
    pkgs.ranger
    pkgs.tree
    pkgs.go
    pkgs.reattach-to-user-namespace
    pkgs.cocoapods
    pkgs.rsync
    pkgs.hugo
    # pkgs.kube3d # Not yet working on arm systems
    pkgs.argocd
    pkgs.mu
    pkgs.unixtools.watch
    doom-emacs # This will install emacs as well
  ];

  # Load the emacs package
  home.file.".emacs.d/init.el".text = ''
      (load "default.el")
  '';

  # Link some common files from the dotfiles directory
  home.file.".vimrc".source = ../dotfiles/vimrc;
  home.file.".gitconfig".source = ../dotfiles/gitconfig;
  home.file.".gitconfig-ben".source = ../dotfiles/gitconfig-ben;
  home.file.".gitconfig-switchdin".source = ../dotfiles/gitconfig-switchdin;
  home.file.".tmux.conf".source = ../dotfiles/tmux.conf;


  # Mail configuration
  programs.msmtp.enable = true;


  # Store mails in ~/Mail
  accounts.email.maildirBasePath = "Mail";

  # Use mbsync to fetch email. Configuration is constructed manually
  # to keep my current email layout.
  programs.mbsync = {
    enable = true;
    extraConfig = lib.mkBefore ''
      MaildirStore ben@harvey.onl-local
      Path ~/Mail/ben@harvey.onl/
      Inbox ~/Mail/ben@harvey.onl/Inbox
      Trash Trash
      SubFolders Verbatim

      IMAPStore ben@harvey.onl-remote
      Host imap.fastmail.com
      Port 993
      User ben@harvey.onl
      PassCmd "sops -d --extract '[\"benHarveyOnl_fastmail\"][\"password\"]' ~/.configuration/secrets/mail.yaml"
      SSLType IMAPS
      SSLVersions TLSv1.2

      Channel ben@harvey.onl
      Master :ben@harvey.onl-remote:
      Slave :ben@harvey.onl-local:
      Patterns *
      Expunge None
      CopyArrivalDate yes
      Sync All
      Create Slave
      SyncState *
    '';
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";
}
