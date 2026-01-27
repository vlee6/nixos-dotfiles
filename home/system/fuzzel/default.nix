{
  config,
  lib,
  ...
}: let
  font = config.stylix.fonts.monospace.name;
  radius = config.theme.rounding;
  background = config.lib.stylix.colors.base07 + "FF";
in {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce "${font}:size=13";
        use-bold = true;
        horizontal-pad = 30;
        vertical-pad = 20;
      };
      border = {
        width = 0;
        radius = radius;
      };
      colors.background = lib.mkForce background;
    };
  };
}
