{ config, lib, pkgs, ... }:

{

  programs.vscode = {
    enable = true;
    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "files.autosave" = "off";
      "window.zoomlevel" = 0;
      "rust-client.rustupPath" = "/home/bscholtz/.nix-profile/bin/rustup";
    };
    extensions = [
      (pkgs.vscode-utils.extensionFromVscodeMarketplace {
        name = "vsliveshare-pack";
        publisher = "MS-vsliveshare";
        version = "0.2.12";
        sha256 = "1y08g56jyy1kr4jqd2x9r72bzd287yfcljbg89ghd4yfnhf4jr23";
      })
      (pkgs.vscode-utils.extensionFromVscodeMarketplace {
        name = "vsliveshare";
        publisher = "MS-vsliveshare";
        version = "1.0.67";
        sha256 = "1shy9xaqz1wsyzzz5z8g409ma5h5kaic0y7bc1q2nxy60gbq828n";
      })
      pkgs.vscode-extensions.bbenoist.Nix
    ];
  };

}
