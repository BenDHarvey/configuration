{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "rqp";
  src = pkgs.fetchurl {
    url = "https://github.com/nib-group/rqp/releases/download/v1.20.2/rqp-1.20.2-darwin.zip";
    sha256 = "f4ae01ab6dbdc9737645106a0d06e856eb2484662104dbf04e4ccdb54889ac59";
  };
  phases = ["installPhase" "patchPhase"];
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/rqp
    chmod +x $out/bin/rqp
  '';
}
