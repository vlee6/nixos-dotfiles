{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  foreground = "${config.lib.stylix.colors.base05}";
  background = "${config.lib.stylix.colors.base00}";
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  stylix.targets.spicetify.enable = false;

  programs.spicetify = {
    enable = true;
    theme = lib.mkForce spicePkgs.themes.text;

    colorScheme = "custom";

    customColorScheme = {
      player = background;
      main = background;
      side = background;
      button = foreground;
      button-active = foreground;
      tab-active = foreground;
    };

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
    ];

    enabledSnippets = with spicePkgs.snippets; [
    ];
  };
}
