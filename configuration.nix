{ pkgs, config, secrets, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable networking
  # networking.networkmanager.enable = true;
  networking.wireless.enable = true;
  networking.wireless.userControlled = true;

  # Wifi
  networking.wireless.networks = {
    "MAKERSPACE" = {
      psk = "12345678";
      priority = 1;
    };

    "Harvard Secure" = {
      auth = ''
        key_mgmt = WPA-EAP
        eap = TLS
        identity = "vlee@college.harvard.edu"
        ca_cert = "/etc/cert/ca.cer"
        client_cert = "/etc/cert/vlee.crt"
        private_key = "/etc/cert/vlee.key"
        private_key_passwd = ${secrets.network_private_key_password}
      '';
      priority = 3;
    };

    "eduroam" = {
      auth = ''
        key_mgmt = WPA-EAP
        eap=TLS
        identity = "vlee@college.harvard.edu"
        ca_cert = "/etc/cert/eduroamca.cer"
        client_cert = "/etc/cert/vlee.crt"
        private_key = "/etc/cert/vlee.key"
        private_key_passwd = ${secrets.network_private_key_password}
      '';
      priority = 2;
    };

    "GIGANET_56" = {
      psk = "2345678900";
    };

  };

  networking.wireless.extraConfig = ''
    update_config=1
  '';

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in xserver
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vlee = {
    isNormalUser = true;
    description = "Victor Lee";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List programs
  programs.firefox.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep 10";
    };
  };

  # List core packages
  environment.systemPackages = with pkgs; [
    brightnessctl
    playerctl
    hyprlock
    hyprshot
    waybar
    python3
    unzip
    wpa_supplicant_gui
    nix-search-tv
    wget
    vscode
    kitty
    waybar
    git
    wofi
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  # List services that you want to enable:
  services.displayManager.ly = {
    enable = true;
    settings = {
      default_session = "Hyprland";
      hide_key_hints = true;
      box_titles = null;
      hide_version_string = true;
    };
  };

  services.pipewire.enable = true;

  services.blueman.enable = true;

  system.stateVersion = "25.11";

}
