{pkgs, ...}: {
  services.displayManager.ly = {
    enable = true;
    settings = {
      hide_key_hints = true;
      box_titles = null;
      hide_version_string = true;
    };
  };
}
