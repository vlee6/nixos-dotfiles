{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    nrfconnect
    nrf-command-line-tools
  ];

  services.udev.packages = [
    pkgs.nrf-udev
    pkgs.segger-jlink
  ];
}
