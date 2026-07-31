{
  pkgs,
  config,
  ...
}: {
  environment = {
    localBinInPath = true;
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Standard C/C++ Libraries & Build Tools
      stdenv.cc.cc.lib
      gcc
      gnumake
      cmake
      pkg-config

      # System C Libraries
      zlib
      glib
      glibc
      libffi
      openssl
      readline
      sqlite
      ncurses
      bzip2
      xz

      # Graphics & Image Libraries
      libGL
      libx11
      libxext
      libxrender
      libxi
      libxcb
      libpng
      libjpeg
      freetype
      fontconfig
      lcms2

      # Performance & Math
      openblas
      lapack

      # NVIDIA CUDA Support
      linuxPackages.nvidia_x11 # nvidia-smi for 1050 ti
      linuxPackages.nvidiaPackages.stable
      cudaPackages.cudatoolkit
      cudaPackages.cuda_cudart
      cudaPackages.libcublas
      cudaPackages.libcufft
      cudaPackages.libcurand
      cudaPackages.libcusparse
      cudaPackages.cudnn
      config.hardware.nvidia.package
    ];
  };
}
