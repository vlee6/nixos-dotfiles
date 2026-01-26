{ inputs, pkgs, ... }: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./languages.nix
    ./mini.nix
    ./options.nix
    ./utils.nix
  ];

  programs.nvf = {
    enable = true;
  };
}
