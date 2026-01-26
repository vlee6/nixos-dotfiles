{ config, secrets, ... }: {
  networking.wireless.enable = true;
  networking.wireless.userControlled = true;

  networking.wireless.networks = {
    "MAKERSPACE" = {
      psk = secrets.makerspace_password;
      priority = 1;
    };

    "Harvard Secure" = {
      auth = ''
        key_mgmt=WPA-EAP
        eap=TLS
        identity="vlee@college.harvard.edu"
        ca_cert="/etc/cert/ca.cer"
        client_cert="/etc/cert/vlee.crt"
        private_key="/etc/cert/vlee.key"
        private_key_passwd="${secrets.harvard_private_key_password}"
      '';
      priority = 3;
    };

    "eduroam" = {
      auth = ''
        key_mgmt=WPA-EAP
        eap=TLS
        identity="vlee@college.harvard.edu"
        ca_cert="/etc/cert/eduroamca.cer"
        client_cert="/etc/cert/vlee.crt"
        private_key="/etc/cert/vlee.key"
        private_key_passwd="${secrets.harvard_private_key_password}"
      '';
      priority = 2;
    };

    "GIGANET_5G" = {
      psk = secrets.giganet_password;
    };
  };

  networking.wireless.extraConfig = ''
    update_config=1
  '';
}
