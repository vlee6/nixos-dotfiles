{ lib, pkgs, config, ... }: {
  options.theme = lib.mkOptions {
    type = lib.types.attrs;
    default = {
      rounding = 4;
      gaps_in = 5;
      gaps_out = 9;

      active_border = rgba(35383cff);
      inactive_border = rgba(ffffff00);
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
      base00 = "27292c"; # Default Background
      base01 = "35383c"; # Lighter background (Status bars, line number)
      base02 = "474c52"; # Selection background
      base03 = "a7a8a7"; # Comments, Invisibles, Line Highlighting
      base04 = "a7a8a7"; # Dark Foreground (Use for status bars)
      base05 = "d7dad8"; # Default Foreground
      base06 = "d7dad8"; # Light Foreground (Not often used)
      base07 = "27292c"; # Light Background (Not often used)
    
      base08 = "d77c79"; # Error
      base09 = "e6a472"; # Urgent
      base0A = "f4cf86"; # Warning
      base0B = "c2c77b";
      base0C = "9ac9c4";
      base0D = "92b2ca";
      base0E = "c0a7c7";
      base0F = "b06a9b"; # Subject to change
    };

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 20;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
	name = "JetBrains Mono Nerd Font";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
	name = "Dejavu Sans";
      };
      serif = config.stylix.fonts.sansSerif;
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
	name = "Noto Color Emoji;"
      };
      sizes = {
        applications = 13;
	desktop = 13;
	popups = 13;
	terminal = 13;
      };
    };

    polarity = "dark";

  };
}
