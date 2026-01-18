{
  description = "Hyprland on Nixos";
	
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    secrets = {
      url = "path:/home/vlee/nixos-secrets";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.hyprland = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({...}: {
          _module.args.secrets = import /home/vlee/nixos-secrets/secrets.nix;
	})
	./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.vlee = import inputs.secrets + "/secrets.nix";
            backupFileExtension = "backup"; 
          };
        }
      ];
    };
  };
}
