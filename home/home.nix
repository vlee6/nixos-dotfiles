{pkgs, config, lib, ...}:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    hypr = "hypr";
    waybar = "waybar";
  };
in

{
  imports = [
    ./modules/neovim.nix
  ];

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


  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;
}
