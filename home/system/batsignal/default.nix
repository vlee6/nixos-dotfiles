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
}
