{
  # https://github.com/vlee6/nixos-dotfiles
  description = ''
    Victor's Nixos configuration with Hyprland
  '';
	
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    nvf.url = "github:notashelf/nvf";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    stylix = {
      url = "github:nix-community/stylix";
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
    laptop = 
      nixpkgs.lib.nixosSystem {
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

}
