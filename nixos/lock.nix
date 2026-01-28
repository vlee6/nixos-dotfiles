{
  security.pam.services.hyprlock = {
    text = ''
      auth include login
    '';

    rules.auth.fail_delay.args = "100000";
  };

  security.pam.faillock.enable = false;
}
