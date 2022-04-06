{ config, lib, pkgs, ... }:

{
  home = { packages = with pkgs; [ mu isync ]; };

  programs = {
    mbsync = {
      enable = true;
      extraConfig = lib.mkBefore ''
        MaildirStore ben@harvey.onl-local
        Path ~/Mail/ben@harvey.onl/
        Inbox ~/Mail/ben@harvey.onl/Inbox
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

    msmtp = { enable = true; };
  };
}
