{pkgs, ...}: let
  chineseSupport3 = pkgs.stdenv.mkDerivation {
    pname = "chinese-support-3";
    version = "2024-02-25";

    src = pkgs.fetchFromGitHub {
      owner = "Gustaf-C";
      repo = "anki-chinese-support-3";
      rev = "v0.16.1";
      hash = "sha256-RInP6lG/y00Uq5p55T6v8G5T5k9U1Y5m8G4j4l3n2m1="; # Replace with actual hash
    };

    installPhase = ''
      mkdir -p $out
      cp -r * $out/
    '';
  };
in {
  programs.anki = {
    enable = true;
    package = pkgs.anki-bin;
    addons = [
      chineseSupport3
    ];
  };
}
