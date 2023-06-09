{
  description = "NixOS system config in flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    secrets = {
      url = "git+ssh://gitolite@mcfly:/bjorn/nixos-secrets?ref=master";
      flake = false;
    };
    
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, agenix, flake-utils, ... }: {
    nixosConfigurations = {

      mcfly = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [ ./hosts/mcfly/configuration.nix
	  {
	    # TODO: This x86_64-linux is wrong should be a system variable
	    environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
          }
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
