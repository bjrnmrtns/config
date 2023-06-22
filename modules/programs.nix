{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neovim
    git
    nmap
    lynx
    fd
    ripgrep
    htop
    tmux
    helix
  ];
}
