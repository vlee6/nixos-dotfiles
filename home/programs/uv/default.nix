{
  home.sessionVariables = {
    UV_TORCH_BACKEND = "cu126";
    TRITON_LIBCUDA_PATH = "/run/opengl-driver/lib";
    TRITON_CUDA_LIB_PATH = "/run/opengl-driver/lib";
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
