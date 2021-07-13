{ config, pkgs, ... }:

with pkgs.lib;
{
  imports = [
    ../modules/settings.nix
  ];

  nixpkgs.config = import ./nixpkgs.nix;
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs.nix;

  home.packages = with pkgs; [
    alacritty
    firefox
    nedit
  ];

  programs.neovim.enable = true;
  programs.neovim.viAlias = true;
  
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
  };

  programs.zsh = {
    enable = true;
  };
}
