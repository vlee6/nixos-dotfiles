{ pkgs, config, lib, ... }:

let
  dotfiles_config = "${config.home.homeDirectory}/nixos-dotfiles/config";
  
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    waybar = "waybar";
  };
in
{
  imports = [
    ./stylix.nix

    ./modules/neovim.nix
    ./modules/vscode.nix
  ];

  programs.home-manager.enable = true;
  
  home.username = "vlee";
  home.homeDirectory = "/home/vlee";
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      nrs = "~/nixos-dotfiles/scripts/nrs.sh";
    };
    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec hyprland
      fi
    '';
  };

  programs.kitty = {
    enable = true;
    extraConfig = ''
      cursor_shape block
      cursor_trail 3
    '';
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
  
        identitiesOnly = true;
        identityFile = [
          "~/.ssh/vleeharvard"
          "~/.ssh/vlee6"
        ];
      };
    };
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles_config}/${subpath}";
      recursive = true;
    })
    configs;
}
