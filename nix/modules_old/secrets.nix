{ config, lib, pkgs, ... }:

{
  home = {
    file.".authinfo.gpg".source = ../../dotfiles/authinfo.gpg;
  };

  programs = {
    gpg = {
      enable = true;
      settings = {
        default-key = "EB4C80B64D5FBF255C5F4633518A2E5A77959839";

        auto-key-locate = "keyserver";
        keyserver = "hkps://hkps.pool.sks-keyservers.net";
        keyserver-options =
          "no-honor-keyserver-url include-revoked auto-key-retrieve";
      };
    };
  };
}
