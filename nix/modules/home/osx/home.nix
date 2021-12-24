  { config, pkgs, ... }:

with import <nixpkgs> {};
with builtins;
with lib;
with import <home-manager/modules/lib/dag.nix> { inherit lib; };

{
  imports = [
    <home-manager/nix-darwin>
    ../homebrew/homebrew.nix
  ];

    programs = {
    alacritty = {
      enable = true;
      settings = {
        font.size = 12;
        normal = {
          family = "Iosevka Nerd Font";
          style = "Regular";
        };
        mouse.hide_when_typing = true;
      };
    };

    zoxide.enable = true;

    go = {
      enable = true;
    };

    msmtp = {
      enable = true;
    };

    mbsync = {
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
  };

    packages = with pkgs; [
      reattach-to-user-namespace
      cocoapods
    ];
}
