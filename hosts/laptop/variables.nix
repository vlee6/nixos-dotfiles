{
  config,
  lib,
  ...
}: {
  imports = [
    # Choose theme here
    ../../themes/custom.nix
  ];

  config.var = {
    hostname = "laptop";
    username = "vlee";
    configDirectory =
      "/home/"
      + config.var.username
      + "nixos-dotfiles/";

    keyboardLayout = "us";
    location = "Boston";
    timeZone = "America/New_York";
    defaultLocale = "en_US.UTF-8";

    git = {
      username = "vleeharvard";
      email = "vlee@college.harvard.edu";
    };

    autoUpgrade = false;
    autoGarbageCollector = true;
  };

  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
