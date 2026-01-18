{
  description = "Hyprland on Nixos";
	
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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
            users.vlee = import ./home/home.nix;  
            backupFileExtension = "backup"; 
          };
        }
      ];
    };
  };
}
