{pkgs, ...}: {
  imports = [./style.nix];
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        height = 26;
        spacing = 9;

        modules-left = [
          "clock"
          "hyprland/workspaces"
        ];

        modules-center = [];

        modules-right = [
          "network"
          "cpu"
          "memory"
          "battery"
          "pulseaudio"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          warp-on-scroll = false;
          format = "{name}";
        };

        clock = {
          format = "{:%I:%M %p, %a %m/%d/%y}";
          tooltip = false;
        };

        cpu = {
          format = "CPU: {usage}%";
          tooltip = false;
        };

        memory = {
          format = "mem: {used}gib";
        };

        battery = {
          format = "Bat: {capacity}%";
          format-plugged = "Bat: {capacity}% ";
          format-time = "{H}:{M}";
        };

        network = {
          format = "Wifi Up";
          format-disconnected = "Disconnected";
        };

        pulseaudio = {
          format = "Vol: {volume}%";
          on-click = "playerctl play-pause";
          tooltip = false;
        };
      }
    ];
  };
}
