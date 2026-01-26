{ pkgs, config }: {
  imports = [
    # Programs
    ../../home/programs/firefox
    ../../home/programs/ghostty
    ../../home/programs/git
    ../../home/programs/nvf
    ../../home/programs/shell
    ../../home/programs/spicetify
    ../../home/programs/thunar
    ../../home/programs/yazi
    
    # System
    ../../home/system/fuzzel
    ../../home/system/hyprland
    ../../home/system/ssh
    ../../home/system/udiskie
    ../../home/system/fuzzel

    ./variables.nix
  ];

  home = {
    # Programs installed here don't need to be configured

    # Apps
    obsidian
    kdePackages.okular
    textpieces
    mpv
    resources

    # Dev
    docker
    nodejs
    python3

    # Just cool
    cbonsai
    cmatrix
    fastfetch

    inherit (config.var) username;
    homeDirectory = "/home/" + config.var.username;
    
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
