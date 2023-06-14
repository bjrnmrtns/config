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

  outputs = inputs@{self, agenix, nixpkgs, home-manager, flake-utils, ... }: 
  let
    baseModules = [
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
    nixosConfigurations = {

      iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = baseModules ++ ["${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"];
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
