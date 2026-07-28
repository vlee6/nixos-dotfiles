{pkgs, ...}: {
  home.packages = [
    (pkgs.symlinkJoin {
      name = "arduino-ide-fixed";
      paths = [pkgs.arduino-ide];
      nativeBuildInputs = [pkgs.makeWrapper];
      postBuild = ''
        # 1. Remove the original binary symlink so we can shadow it
        rm $out/bin/arduino-ide

        # 2. Create an outer shell wrapper (keeps Electron asset paths intact)
        makeWrapper ${pkgs.arduino-ide}/bin/arduino-ide $out/bin/arduino-ide \
          --set GDK_BACKEND x11 \
          --add-flags "--ozone-platform=x11 --password-store=basic"

        # 3. Replace the desktop entry symlink with a clean, writable copy
        rm $out/share/applications/arduino-ide.desktop
        cp ${pkgs.arduino-ide}/share/applications/arduino-ide.desktop $out/share/applications/arduino-ide.desktop
        chmod +w $out/share/applications/arduino-ide.desktop

        # 4. Rewrite the Exec line to a clean format that Wofi easily understands
        sed -i "s|Exec=.*|Exec=arduino-ide %U|" $out/share/applications/arduino-ide.desktop
      '';
    })
  ];
}
