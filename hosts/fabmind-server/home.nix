{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Programs
    ../../home/programs/ghostty
    ../../home/programs/git
    ../../home/programs/nvf
    ../../home/programs/shell

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
      resources

      # Dev
      nixos-install-tools
      docker
      nodejs
      python3
      ffmpeg
      caligula
      ngrok

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
