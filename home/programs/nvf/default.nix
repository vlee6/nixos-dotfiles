{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./keymaps.nix
    ./languages.nix
    ./mini.nix
    ./options.nix
    ./utils.nix
  ];

  programs.nvf = {
    enable = true;
  };
}
