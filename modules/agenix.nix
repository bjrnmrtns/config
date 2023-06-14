{ agenix, config, pkgs, ... }: {

  imports = [
    agenix.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    age agenix.packages.${system}.default
  ];
}
