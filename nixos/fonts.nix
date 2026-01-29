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
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <alias>
            <family>serif</family>
            <prefer><family>${sansSerif}</family></prefer>
          </alias>
          <alias>
            <family>sans-serif</family>
            <prefer><family>${sansSerif}</family></prefer>
          </alias>
          <match target="pattern">
            <test name="family"><string>Arial</string></test>
            <edit name="family" mode="assign" binding="strong">
              <string>${sansSerif}</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };

    enableDefaultPackages = false;
  };
}
