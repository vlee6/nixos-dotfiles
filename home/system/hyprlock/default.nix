{
  pkgs,
  config,
  ...
}: let
  hexToRgba = hex: alpha: let
    h = builtins.substring 1 6 hex;
    r = builtins.parseInt 16 (builtins.substring 0 2 h);
    g = builtins.parseInt 16 (builtins.substring 2 2 h);
    b = builtins.parseInt 16 (builtins.substring 4 2 h);
  in "rgba(${toString r}, ${toString g}, ${toString b}, ${toString alpha})";

  background = "#${config.lib.stylix.colors.base07}";
  foreground = "#${config.lib.stylix.colors.base05}";
  fail = "#${config.lib.stylix.coors.base08}";
in {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        no_fade_in = true;
        no_fade_out = true;
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
      };

      input-field = [
        {
          size = "400, 60";
          position = "0, 0";
          halign = "center";
          valign = "center";
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;

          outer_color = hexToRgba background 1.0;
          inner_color = hexToRgba background 1.0;
          font_color = hexToRgba foreground 1.0;
          fail_color = hexToRgba fail 1.0;

          fade_on_empty = false;
          hide_input = false;
        }
      ];
    };
  };
}
