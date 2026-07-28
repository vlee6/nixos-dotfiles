{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = [
    (pkgs.symlinkJoin {
      name = "kicad-wrapped";
      paths = [pkgs.kicad];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/kicad \
          --set GDK_BACKEND x11 \
          --set GDK_SCALE 1.25 \
          --set GDK_DPI_SCALE 1.25
      '';
    })
  ];
}
