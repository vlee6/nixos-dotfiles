{config, ...}: let
  username = config.var.git.username;
  email = config.var.git.email;
in {
  programs.git = {
    enable = true;
    ignores = [

    ];
    settings = {
      user.name = username;
      user.email = email;
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      color.ui = "1";
      alias = {

      }; 
    };
  };
}
