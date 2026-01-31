{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = [
    (pkgs.kicad.overrideAttrs (oldAttrs: {
      nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [pkgs.makeWrapper];
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          wrapProgram $out/bin/kicad \
            --set GDK_BACKEND x11 \
            --set GDK_SCALE 1.25 \
            --set GDK_DPI_SCALE 1.25 \
        '';
    }))
  ];

  xresources.properties = lib.mkForce {
    "Xcursor.size" = 24;
  };
}
