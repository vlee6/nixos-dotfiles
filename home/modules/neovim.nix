{ pkgs, config, lib, ... }:

{
  # Install Neovim and dependencies
  home.packages = with pkgs; [
    wl-clipboard
    gef

    # Tools required for Telescope
    ripgrep
    fd
    fzf

    # Nix language server and formatter
    nil
    nixpkgs-fmt

    # C/C++
    clang-tools
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      telescope-nvim
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      mini-nvim
      smear-cursor-nvim
    ];

    extraConfig = ''
      set clipboard=unnamedplus
      syntax on
      set number
    '';

  };

}
