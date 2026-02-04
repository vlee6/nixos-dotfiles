{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  foreground = "1DB954";
  background = "${config.lib.stylix.colors.base00}";
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  stylix.targets.spicetify.enable = false;

  programs.spicetify = {
    enable = true;
    theme = lib.mkForce spicePkgs.themes.text;

    colorScheme = "custom";

    customColorScheme = {
      main = background;
      side = background;
      player = foreground;
      button = foreground;
      button-active = foreground;
      button-disabled = foreground;
      tab-active = foreground;
      misc = foreground;
    };

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
    ];
  };
}
