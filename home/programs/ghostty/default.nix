{
  programs.ghostty = {
    enable = true;
    installVimSyntax = true;
    enableZshIntegration = true;
    settings = {
      custom-shader = "./shaders/cursor_warp.glsl";
    };
  };
}
