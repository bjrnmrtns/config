{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    nmap
    lynx
    fd
    ripgrep
    htop
  ];
}
