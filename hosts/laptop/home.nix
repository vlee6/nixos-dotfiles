{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Programs
    ../../home/programs/anki
    ../../home/programs/firefox
    ../../home/programs/ghostty
    ../../home/programs/git
    ../../home/programs/kicad
    ../../home/programs/nvf
    ../../home/programs/shell
    ../../home/programs/spicetify
    ../../home/programs/thunar
    ../../home/programs/vscode
    ../../home/programs/yazi
    ../../home/programs/zoom

    # System
    ../../home/system/batsignal
    ../../home/system/dunst
    ../../home/system/fuzzel
    ../../home/system/hypridle
    ../../home/system/hyprland
    ../../home/system/hyprlock
    ../../home/system/hyprpaper
    ../../home/system/ssh
    ../../home/system/udiskie
    ../../home/system/waybar

    ./variables.nix
  ];

  home = {
    # Packages installed here don't need to be configured
    packages = with pkgs; [
      # Apps
      obsidian
      kdePackages.okular
      kdePackages.kdenlive
      audacity
      mpv
      slack
      resources
      htop
      libreoffice
      obs-studio

      # Dev
      docker
      nodejs
      python3
      prusa-slicer
      arduino-ide
      ffmpeg

      # Just cool
      asciiquarium
      cava
      cbonsai
      cmatrix
      fastfetch
      figlet
      lolcat
      tty-clock
    ];

    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
