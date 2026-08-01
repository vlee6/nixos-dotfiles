{lib, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
    };
  };

  systemd.user.services.hyprpaper = {
    Unit.After = lib.mkForce "graphical-session.target";
    Install.WantedBy = ["hyprland-session.target" "graphical-session.target"];
  };
}
