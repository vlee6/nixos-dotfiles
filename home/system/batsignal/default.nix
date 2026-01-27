{
  services.batsignal = {
    enable = true;
    extraArgs = [
      "-c"
      "20" # Critical at 20%
    ];
  };
}
