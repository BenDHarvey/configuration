{ config, lib, pkgs, ... }:

with import <nixpkgs> { };

{
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
          "browser.search.region" = "AU";
          "browser.uidensity" = 1;
          "browser.search.openintab" = true;
          "xpinstall.signatures.required" = false;
          "extensions.update.enabled" = false;
          "pdfjs.disabled" = true;
          "media.videocontrols.picture-in-picture.enabled" = true;
          "browser.bookmarks.showMobileBookmarks" = true; # Mobile bookmarks
          "browser.download.useDownloadDir" = false; # Ask for download location
          "browser.in-content.dark-mode" = true; # Dark mode
          "browser.newtabpage.activity-stream.feeds.section.topstories" =
            false; # Disable top stories
          "browser.newtabpage.activity-stream.feeds.sections" = false;
          "browser.newtabpage.activity-stream.feeds.system.topstories" =
            false; # Disable top stories
          "browser.newtabpage.activity-stream.section.highlights.includePocket" =
            false; # Disable pocket
          "extensions.pocket.enabled" = false; # Disable pocket
          "media.eme.enabled" = true; # Enable DRM
          "media.gmp-widevinecdm.visible" = true; # Enable DRM
          "media.gmp-widevinecdm.enabled" = true; # Enable DRM
          "signon.autofillForms" = false; # Disable built-in form-filling
          "signon.rememberSignons" = false; # Disable built-in password manager
          "ui.systemUsesDarkTheme" = true; # Dark mode
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
