{
  pkgs,
  config,
  lib,
  ...
}: let
  radius = config.theme.rounding;
  background = config.lib.stylix.colors.base07 + "FF";
in {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce "JetBrains Mono Nerd Font";
      };
      border = {
        width = 0;
        radius = radius;
      };
      colors.background = lib.mkForce background;
    };
  };
}
