{ pkgs, ... }: {
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

    enableDefaultPackages = false;
  };
}
