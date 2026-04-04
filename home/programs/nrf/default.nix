{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    nrfconnect
    nrf-command-line-tools
  ];
}
