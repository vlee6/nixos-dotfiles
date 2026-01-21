{
  description = "Hyprland on Nixos";
	
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets_dir = {
      url = "path:/home/vlee/nixos-secrets";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      ...
    }:
  let
    colors = import ./home/colors.nix;
  in {
    nixosConfigurations.hyprland = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        secrets = import "${self.inputs.secrets_dir}/secrets.nix";
	inherit colors;
      };
      
      modules = [
	./configuration.nix
	stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = {
	      inherit colors;
	    };

            users.vlee = import ./home/home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
