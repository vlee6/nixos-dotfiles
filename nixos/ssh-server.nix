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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJxBqZ96lJ4wfDfu9Lp9iwK8mYahz0pCAthq9gNNlLjZ ${username}@laptop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBZzyynU03vsvVELsel6hMX/HP75iwoP+NPja8vKVJNC ${username}@fabmind-server"
    ];
  };
}
