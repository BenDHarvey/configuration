{
  allowUnfree = true;
  chromium = { enableWideVine = true; };
  packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball
      "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
  };
  permittedInsecurePackages = [ "openssl-1.0.2u" ];
}
