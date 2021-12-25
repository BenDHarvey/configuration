{ config, lib, pkgs, ... }:

with import <nixpkgs> { };

{
  home = { packages = with pkgs; [ mu isync ]; };

  programs = {
    firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        #        userChrome = ''
        #          #TabsToolbar {
        #            visibility: collapse;
        #          }
        #          toolbar#nav-bar, nav-bar-customization-target {
        #            background: ${thm.bg} !important;
        #          }
        #          @-moz-document url("about:newtab") {
        #            * { background-color: ${thm.bg}  !important; }
        #          }
        #        '';
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

          "extensions.autoDisableScopes" = 0;

          "browser.search.defaultenginename" = "Google";
          "browser.search.selectedEngine" = "Google";
          "browser.urlbar.placeholderName" = "Google";
          "browser.search.region" = "US";

          "browser.uidensity" = 1;
          "browser.search.openintab" = true;
          "xpinstall.signatures.required" = false;
          "extensions.update.enabled" = false;
          #
          #          "font.name.monospace.x-western" = "IBM Plex Mono";
          #          "font.name.sans-serif.x-western" = "IBM Plex Sans";
          #          "font.name.serif.x-western" = "IBM Plex Serif";
          #
          #          "browser.display.background_color" = thm.bg;
          #          "browser.display.foreground_color" = thm.fg;
          #          "browser.display.document_color_use" = 2;
          #          "browser.anchor_color" = thm.fg;
          #          "browser.visited_color" = thm.blue;
          #          "browser.display.use_document_fonts" = true;
          #          "pdfjs.disabled" = true;
          #          "media.videocontrols.picture-in-picture.enabled" = true;
        };
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        close-other-windows
        adsum-notabs
        ublock-origin
        vimium
      ];
    };
  };
}
