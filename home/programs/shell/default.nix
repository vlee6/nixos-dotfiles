{
  pkgs,
  lib,
  config,
  ...
}: let
  fetch = config.theme.fetch; # Run fetch on startup?
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "regexp" "root" "line"];
    };

    history = {
      ignoreDups = true;
      save = 10000;
      size = 10000;
    };

    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#laptop";
    };

    # Emacs style navigation since Nvim navigation in shell sucks
    initContent = ''
      bindkey -e
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word
      bindkey "^H" backward-kill-word
    '';
  };
  programs.pay-respects.enable = true;
}
