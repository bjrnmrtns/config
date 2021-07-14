{ config, pkgs, ... }:

with pkgs.lib;
{
  imports = [
    ../modules/settings.nix
  ];

  nixpkgs.config = import ./nixpkgs.nix;
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs.nix;
  xdg.configFile."nvim/init.vim".source = ./nvim/init.vim;
  xdg.configFile."alacritty/alacritty.yml".source = ./alacritty.yml;
  xdg.configFile."tmux/tmux.conf".source = ./tmux.conf;
  xdg.configFile."i3/config".source = i3/config;

  home.packages = with pkgs; [
    alacritty
    firefox
    nedit
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
  };
  
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    };
    shellAliases = {
      gg = "git status";
    };
  };

  programs.qutebrowser.enable = true;
}
