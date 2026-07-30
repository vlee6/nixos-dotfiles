{
  home.sessionVariables = {
    UV_TORCH_BACKEND = "cu126";
  };

  programs.uv = {
    enable = true;

    python = {
      versions = ["3.13"];
      default = ["3.13"];
      prune = true;
    };

    tool = {
      packages = [
        "ipython"
        "notebook"
      ];
      prune = true;
    };
  };
}
