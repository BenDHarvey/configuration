{config, lib, pkgs, ...}:

{
  services.yabai.package = pkgs.yabai;
  services.yabai.enableScriptingAddition = false;
  services.yabai.enable = true;

  services.skhd.enable = true;
  services.skhd.package =  pkgs.skhd;
}
