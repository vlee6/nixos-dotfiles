{...}: {
  powerManagement.enable = true;

  services = {
    tlp.enable = true;
    thermald.enable = true;
    upower.enable = true;
  };
}
