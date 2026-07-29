{config, ...}: {
  imports = [
    # System configuration
    ../../nixos/docker.nix
    ../../nixos/fonts.nix
    ../../nixos/home-manager.nix
    ../../nixos/hyprland.nix
    ../../nixos/nix.nix
    # ../../nixos/systemd-boot.nix
    ../../nixos/ssh-server.nix
    ../../nixos/users.nix
    ../../nixos/utils.nix
    ../../nixos/wsl.nix
    # ../../nixos/wifi.nix

    # ./hardware-configuration.nix
    ./variables.nix
  ];

  home-manager.users."${config.var.username}" = import ./home.nix;

  system.stateVersion = "25.11";
}
