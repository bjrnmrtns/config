{
  description = "NixOS system config in flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-utils, ... }: {
    nixosConfigurations = {
      "mcfly" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  ./configuration.nix
	  ./modules/gitolite.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.bjorn = import ./home.nix;
	  }
	];
      };
    };
  };
}
