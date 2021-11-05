{ pkgs ? import <nixpkgs> {} }:
pkgs.stdenv.mkDerivation {
  name = "kexpand";
  src = pkgs.fetchurl {
    url = "https://github.com/kopeio/kexpand/releases/download/0.2/kexpand-linux-amd64";
    sha256 = "0ldh303r5063kd5y73hhkbd9v11c98aki8wjizmchzx2blwlipy7";
  };
  phases = ["installPhase" "patchPhase"];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/kexpand
    chmod +x $out/bin/kexpand
  '';
}
