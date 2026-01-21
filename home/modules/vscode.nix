{ pkgs, config, lib, ...}:

{
  home.packages = with pkgs; [
    vscode.fhs
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs; # Necessary for plugins requiring FHS compiancy  

    extensions = with pkgs.vscode-extensions; [
      # Vim
      vscodevim.vim
      
      # Tools
      ms-vscode.live-server

      # Languages
      ms-python.python
      ms-vscode.cpptools-extension-pack

    ];

    progams.vscode.package = pkgs.vscode.fhsWithPackages (ps: with ps; [
      # Dependencies in FHS environment go here
    ]);
  };
}
