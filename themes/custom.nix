{
  lib,
  pkgs,
  config,
  ...
}: {
  options.theme = lib.mkOption {
    type = lib.types.attrs;
    default = {
      rounding = 4;
      gaps_in = 5;
      gaps_out = 9;

      active_border = "rgba(35383cff)";
      inactive_border = "rgba(ffffff00)";
      active_opacity = 1;
      inactive_opacity = 1;
      dim_inactive = true;
      dim_strength = 0.2;

      shadow = false;
      blur = false;

      border_size = 3;

      animation_speed = "fast";
      fetch = "none";

      textColorOnWallpaper =
        config.lib.stylix.colors.base00;
    };

    description = "Theme configuration options";
  };

  config.stylix = {
    enable = true;

    base16Scheme = {
      base00 = "1d1f21"; # Default Background
      base01 = "282a2e"; # Lighter background (Status bars, line number)
      base02 = "373b41"; # Selection background
      base03 = "969896"; # Comments, Invisibles, Line Highlighting
      base04 = "a7a8a7"; # Dark Foreground (Use for status bars)
      base05 = "d7dad8"; # Default Foreground
      base06 = "d7dad8"; # Light Foreground (Not often used)
      base07 = "17191a"; # Originally light Background, switched to dark background

      base08 = "cc6666"; # Error
      base09 = "de935f"; # Urgent
      base0A = "f0c674"; # Warning
      base0B = "b5bd68";
      base0C = "8abeb7";
      base0D = "81a2bE";
      base0E = "b294bb";
      base0F = "a3685a"; # Subject to change
    };

    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono Nerd Font";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      serif = {
        package = pkgs.cm_unicode;
        name = "CMU Serif";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = 12;
        desktop = 12;
        popups = 12;
        terminal = 12;
      };
    };

    image = ./wallpapers/black.png;

    polarity = "dark";
  };
}
