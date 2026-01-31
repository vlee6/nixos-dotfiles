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
      mpv
      slack
      resources

      # Dev
      docker
      nodejs
      python3

      # Just cool
      cbonsai
      cmatrix
      fastfetch
      tty-clock
      htop
    ];

    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;

    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
