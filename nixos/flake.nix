{
  description = "NixOS system flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.nixpkgs.follows = "nixops/nixpkgs";

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      "mcfly" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

	modules = [
	  ./configuration.nix
	];
      }
    }
  };
}
