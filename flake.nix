{
  # https://github.com/vlee6/nixos-dotfiles
  description = ''
    Victor's Nixos configuration with Hyprland
  '';
	
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    nvf.url = "github:notashelf/nvf";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
   
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    secrets_dir = {
      url = "path:/home/vlee/nixos-secrets";
      flake = false;
    };
  };

  outputs = inputs @ {nixpkgs, ...}: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

	specialArgs = {
          secrets = import "${inputs.secrets_dir}/secrets.nix";
	};

        modules = [
	  {
            nixpkgs.overlays = [];
  	    _module.args = {
  	      inherit inputs;
  	    };
  	  }
  	  inputs.home-manager.nixosModules.home-manager
  	  inputs.stylix.nixosModules.stylix
  	  ./hosts/laptop/configuration.nix
  	];
      };
    };
  };
}
