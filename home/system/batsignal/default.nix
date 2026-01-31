{
  services.batsignal = {
    enable = true;
    extraArgs = [
      "-w"
      "30" # Warning at 25%
      "-c"
      "20" # Critical at 20%
    ];
  };
}
