{ pkgs, config, lib, ...}

{
  # Install Neovim and dependencies
  home.packages = with pkgs; [
    # Tools required for Telescope
    ripgrep
    fd
    fzf

    # Language servers
    
    # Nix
    nil
    nixpkgs-fmt

    # C/C++
    clangd


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
      smear-cursor
    ];

  }

}
