{
  description = "NixOS system config in flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    secrets = {
      url = "git+ssh://gitolite@mcfly:/bjorn/nixos-secrets?ref=master";
      flake = false;
    };
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, agenix, flake-utils, ... }@inputs: {
    nixosConfigurations = {
      "mcfly" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  {
	    # TODO: This x86_64-linux is wrong should be a system variable
	    environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
          }
	  ./configuration.nix
	  ./modules/gitolite.nix
	  agenix.nixosModules.default
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.bjorn = import ./home.nix;
	  }
	];
	specialArgs = { inherit (inputs) secrets; };
      };
    };
  };
}
