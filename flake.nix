{
  description = "NixOS system config in flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    secrets = {
      url = "git+ssh://gitolite@mcfly:/bjorn/nixos-secrets?ref=master";
      flake = false;
    };
    
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{self, agenix, nixpkgs, nix-darwin, home-manager, flake-utils, ... }: 
  let
    isoModules = [
      agenix.nixosModules.age
      ({ lib, pkgs,  ... }: {
        nix = {
          package = pkgs.nixUnstable;
          extraOptions = "experimental-features = nix-command flakes recursive-nix";
        };

        networking = {
          networkmanager.enable = true;
          wireless.enable = lib.mkForce false;
          # ^because WPA Supplicant cannot run with NetworkManager
        };

        environment.systemPackages = with pkgs; [
          age agenix
          curl git neovim tmux
        ];
      })
    ];
  in {
    darwinConfigurations = {
      jennifer = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./hosts/jennifer/configuration.nix
        ];
        inputs = {inherit nix-darwin nixpkgs; };
      };
    };
    nixosConfigurations = {
      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = isoModules ++ ["${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"];
      };

      mcfly = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [ ./hosts/mcfly/configuration.nix
	  home-manager.nixosModules.home-manager {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.bjorn = import ./home.nix;
	  }
	];
	specialArgs = { inherit (inputs) agenix secrets; };
      };
    };
  };
}
