{
  pkgs,
  config,
  ...
}: let
  sansSerif = config.stylix.fonts.sansSerif.name;
  serif = config.stylix.fonts.serif.name;
in {
  fonts = {
    packages = with pkgs; [
      roboto
      lato
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      nerd-fonts.jetbrains-mono
      openmoji-color
    ];

    fontconfig = {
      defaultFonts = {
        sansSerif = ["${sansSerif}"];
        serif = ["${serif}"];
      };
    };

    enableDefaultPackages = false;
  };
}
