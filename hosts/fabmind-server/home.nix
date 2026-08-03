{
  pkgs,
  config,
  ...
}: {
  imports = [
    # Programs
    ../../home/programs/git
    ../../home/programs/nvf
    ../../home/programs/shell
    ../../home/programs/uv

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

    pointerCursor.enable = true;

    stateVersion = "25.11";
  };

  dconf.enable = false;
  programs.home-manager.enable = true;
}
