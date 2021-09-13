# This came from here... https://github.com/malob/nixpkgs still needs some work to get it running
{ config, lib, ... }:

let
  mkIfCaskPresent = cask: lib.mkIf (lib.any (x: x == cask) config.homebrew.casks);
in

{
  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";
  homebrew.global.brewfile = true;
  homebrew.global.noLock = true;

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
  ];

  # Prefer installing application from the Mac App Store
  #
  # Commented apps suffer continual update issue:
  # https://github.com/malob/nixpkgs/issues/9
  homebrew.masApps = {
#    # "1Blocker" = 1365531024;
    "1Password" = 1333542190;
#    "Accelerate for Safari" = 1459809092;
#    "Apple Configurator 2" = 1037126344;
#    DaisyDisk = 411643860;
#    "Dark Mode for Safari" = 1397180934;
#    Deliveries = 290986013;
#    Fantastical = 975937182;
#    "Gemini 2" = 1090488118;
#    "iMazing Profile Editor" = 1487860882;
#    Keynote = 409183694;
#    "LG Screen Manager" = 1142051783;
#    MindNode = 1289197285;
#    Numbers = 409203825;
#    Pages = 409201541;
#    Patterns = 429449079;
#    "Pixelmator Classic" = 407963104;
#    "Pixelmator Pro" = 1289583905;
#    "Save to Raindrop.io" = 1549370672;
#    Slack = 803453959;
#    SiteSucker = 442168834;
#    "Things 3" = 904280696;
#    TripMode = 1513400665;
#    Ulysses = 1225570693;
#    Vimari = 1480933944;
#    "WiFi Explorer" = 494803304;
#    Xcode = 497799835;
#    "Yubico Authenticator" = 1497506650;
  };

  # If an app isn't available in the Mac App Store, or the version in the App Store has
  # limitiations, e.g., Transmit, install the Homebrew Cask.
  homebrew.casks = [
#    "atom"
#    "amethyst"
#    "arq"
#    "audio-hijack"
#    "balenaetcher"
#    "camo-studio"
#    "cloudflare-warp"
#    "displaycal"
#    "firefox"
#    "google-chrome"
#    "google-drive"
#    "gpg-suite"
#    "hammerspoon"
#    "hey"
#    "i1profiler"
#    "keybase"
#    "nvidia-geforce-now"
#    "obsidian"
#    "parallels"
#    "plover"
#    "protonvpn"
#    "raindropio"
#    "raycast"
#    "secretive"
#    "signal"
#    "skype"
#    "steam"
#    "superhuman"
#    "tastyworks"
#    "tor-browser"
#    "transmission"
#    "transmit"
#    "visual-studio-code"
    "vlc"
#    "yubico-yubikey-manager"
#    "yubico-yubikey-personalization-gui"
  ];

  # Configuration related to casks
#  environment.variables.SSH_AUTH_SOCK = mkIfCaskPresent "secretive"
#     "/Users/${config.users.primaryUser}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";

  # For cli packages that aren't currently available for macOS in `nixpkgs`.Packages should be
  # installed in `../home/default.nix` whenever possible.
#  homebrew.brews = [
#    "swift-format"
#    "swiftlint"
#  ];
}
