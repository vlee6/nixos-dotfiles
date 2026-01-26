{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    vscode.fhs
  ];

  programs.vscode = {
    enable = true;

    # Necessary for plugins requiring FHS compiancy
    package = pkgs.vscode.fhsWithPackages (ps:
      with ps; [
        # Dependencies in FHS environment go here
      ]);

    extensions = with pkgs.vscode-extensions; [
      # Vim
      asvetliakov.vscode-neovim

      # Tools
      ms-vscode.live-server

      # Languages
      ms-python.python
      ms-vscode.cpptools-extension-pack

      # PlatformIO
      platformio.platformio-vscode-ide
    ];
  };
}
