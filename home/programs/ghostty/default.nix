{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      custom-shader = "${./shaders/cursor_warp.glsl}";
    };
  };
}
