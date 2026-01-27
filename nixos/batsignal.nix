{
  services.upower.enable = true;

  services.batsignam = {
    enable = true;
    extraArgs = [
      "-c"
      "20" # Critical at 20%
    ];
  };
}
