{ pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [
    vscode.fhs
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs; # Installs vscode in an FHS compatible environment which may be necessary for some extensions
    extensions = with pkgs.vscode-extensions; [
      # Vim
      vscodevim.vim

      # Development tools
      ms-vscode.live-server

      # Language support
      ms-vscode.cpptools-extension-pack 
      ms-python.python
    ];

    
  };

  programs.vscode.package = pkgs.vscode.fhsWithPackages (ps: with ps; [
    # FHS required packages go here
  ]);
}
