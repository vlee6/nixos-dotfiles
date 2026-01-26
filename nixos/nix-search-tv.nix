{ pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.writeShellApplication {
      name = "ns";

      runtimeInputs = with pkgs; [
        fzf
        nix-search-tv
      ];

      text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";

      excludeShellChecks = [ "SC2016" ];
    })
  ];
}
