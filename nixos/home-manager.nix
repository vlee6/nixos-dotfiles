{inputs, ...}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
    backupCommand = ''
      mv "$1" "$1.$(date +%s).bak"
    '';
  };
}
