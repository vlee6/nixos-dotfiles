{pkgs, ...}: let
  chineseSupport3 = pkgs.stdenv.mkDerivation {
    pname = "chinese-support-3";
    version = "0.17.1";

    src = pkgs.fetchgit {
      url = "https://github.com/Gustaf-C/anki-chinese-support-3.git";
      rev = "0.17.1";
      hash = "sha256-23zS3nqo3U0NMVjnAS0Jp9hcCMqVgk1P/vJ+j8ZsSFU=";
    };

    dontBuild = true;
    dontCheck = true;

    installPhase = ''
      mkdir -p $out
      cp -r * $out/
    '';
  };
in {
  programs.anki = {
    enable = true;
    package = pkgs.anki;
    addons = [
      chineseSupport3
    ];
  };
}
