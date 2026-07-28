{pkgs, ...}: {
  services.batsignal = {
    enable = true;
    extraArgs = [
      "-w"
      "30"
      "-c"
      "20"
    ];
  };
  systemd.user.services.batsignal.Install.WantedBy = ["graphical-session.target"];
}
