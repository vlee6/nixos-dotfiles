{
  config,
  lib,
  ...
}: let
  hexToRgb = hex: let
    cleanHex = let
      firstChar = builtins.substring 0 1 hex;
    in
      if firstChar == "#"
      then lib.toLower (builtins.substring 1 (builtins.stringLength hex) hex)
      else lib.toLower hex;
    dict = {
      "0" = 0;
      "1" = 1;
      "2" = 2;
      "3" = 3;
      "4" = 4;
      "5" = 5;
      "6" = 6;
      "7" = 7;
      "8" = 8;
      "9" = 9;
      "a" = 10;
      "b" = 11;
      "c" = 12;
      "d" = 13;
      "e" = 14;
      "f" = 15;
    };
    hexPairToDec = s: (dict.${builtins.substring 0 1 s} * 16) + dict.${builtins.substring 1 1 s};
    r = hexPairToDec (builtins.substring 0 2 cleanHex);
    g = hexPairToDec (builtins.substring 2 2 cleanHex);
    b = hexPairToDec (builtins.substring 4 2 cleanHex);
  in "rgb(${toString r}, ${toString g}, ${toString b})";

  background = "#${config.lib.stylix.colors.base07}";
  foreground = "#${config.lib.stylix.colors.base05}";
  fail = "#${config.lib.stylix.colors.base08}";
  check = "#${config.lib.stylix.colors.base07}";
  font = config.stylix.fonts.monospace.name;
in {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        no_fade_in = true;
        no_fade_out = false;
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
        fail_timeout = 1000;
        fail_transition = 1;
      };

      input-field = lib.mkForce [
        {
          monitor = "";
          size = "400, 60";
          position = "0, 0";
          halign = "center";
          valign = "center";
          dots_size = 0.2;
          dots_spacing = 0.35;
          dots_center = true;

          outer_color = "rgba(00, 00, 00, 00)";
          inner_color = "rgba(00, 00, 00, 00)";
          font_color = hexToRgb foreground;
          fail_color = hexToRgb fail;
          check_color = "rgba(00, 00, 00, 00)";

          placeholder_text = "<i><span font='${font}'>Input Password...</span></i>";
          fail_text = "<i><span font='${font}'>Authentication Failed</span></i>";

          fade_on_empty = false;
          hide_input = false;
        }
      ];
    };
  };
}
