{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com-harvard" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/vleeharvard";
      };
      "github.com-personal" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/vlee6";
      };
    };
  };
}
