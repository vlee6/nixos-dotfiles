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
        "ipykernel"
        "ipywidgets"
        "notebook"

        "matplotlib"
        "matplotlib-label-lines"
        "numpy"
        "scipy"
        "pandas"
        "torch"
        "einops"
        "einx"
        "tqdm"
        "pathlib"

        "pythae"
        "torchvision"

        "vector_quantize_pytorch"
      ];
      prune = true;
    };
  };
}
