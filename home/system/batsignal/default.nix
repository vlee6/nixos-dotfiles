{
  services.batsignal = {
    enable = true;
    extraArgs = [
      "-w"
      "25" # Warning at 25%
      "-c"
      "20" # Critical at 20%
      "-d"
      "15" # Danger at 15% (optional, but good to keep levels descending)
    ];
  };
}
