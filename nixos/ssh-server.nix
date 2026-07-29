{
  config,
  pkgs,
  ...
}: let
  username = config.var.username;
in {
  services.openssh = {
    enable = true;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = ["vlee"];
    };
  };

  users.users.${username} = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMw7rODwcEweRCCb89gX7P6hwI+0o5zcdt5gx9/aVgGb ${username}@laptop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBZzyynU03vsvVELsel6hMX/HP75iwoP+NPja8vKVJNC ${username}@fabmind-server"
    ];
  };
}
