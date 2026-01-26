{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
  
        identitiesOnly = true;
        identityFile = [
          "~/.ssh/vleeharvard"
          "~/.ssh/vlee6"
        ];
      };
    };
  };
}
