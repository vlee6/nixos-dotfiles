{
  pkgs,
  config,
  lib,
  ...
}: let
  font = config.stylix.fonts.monospace.name;
  urgency_critical = "#" + config.lib.stylix.colors.base08;
  urgency_normal = "#" + config.lib.stylix.colors.base07;
  urgency_low = urgency_normal;
in {
  home.packages = with pkgs; [
    libnotify
    glib
  ];

  services.dunst = {
    enable = true;

    settings = {
      global = {
        font = lib.mkForce font;
        frame_width = 0;
        separator_color = lib.mkForce urgency_normal;
        origin = "top-right";
        offset = "0x0";
      };

      urgency_low = {
        background = lib.mkForce urgency_low;
      };

      urgency_normal = {
        background = lib.mkForce urgency_normal;
      };

      urgency_critical = {
        background = lib.mkForce urgency_critical;
      };
    };
  };
}
