{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = [
    pkgs.python3
  ];

  env.LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
    pkgs.stdenv.cc.cc.lib
    pkgs.libz
    pkgs.libGL
    pkgs.libxkbcommon
    pkgs.libX11
    pkgs.libxft
    pkgs.glib
    pkgs.fontconfig
    pkgs.freetype
    pkgs.zstd
  ];
}
