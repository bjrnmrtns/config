{ config, pkgs, inputs, ... }: {

  imports = [
    inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    age inputs.agenix.packages.${system}.default
  ];
}
