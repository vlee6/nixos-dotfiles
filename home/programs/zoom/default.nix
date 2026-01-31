{
  pkgs,
  config,
  ...
}: {
  home.packages = [
    (pkgs.zoom-us.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.makeWrapper];
      postFixup =
        (old.postFixup or "")
        + ''
          wrapProgram $out/bin/zoom \
            --set GDK_BACKEND x11 \
            --set GDK_SCALE 1.25 \
            --set GDK_DPI_SCALE 1.25 \
        '';
    }))
  ];
}
