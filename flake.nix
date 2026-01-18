{
  description = "Hyprland on Nixos";
	
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets_dir = {
      url = "path:/home/vlee/nixos-secrets";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.hyprland = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        secrets = import "${self.inputs.secrets_dir}/secrets.nix";
      };
      
      modules = [
	./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.vlee = import ./home/home.nix;
            backupFileExtension = "backup"; 
          };
        }
      ];
    };
  };
}
