{pkgs, ...}: {
  wsl = {
    enable = true;
    defaultUser = "vlee";
    useWindowsDriver = true;
  };

  hardware.graphics.enable = true;

  environment.sessionVariables = {
    LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
  };
}
