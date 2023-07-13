{ pkgs, lib, inputs, headless ? true, ... }: {

  imports = [
    ../modules/neovim.nix
    ../modules/helix.nix
  ] ++ lib.optional (!headless) ./desktop.nix;
  
  home = {
    username = "bjorn";
    homeDirectory = "/home/bjorn";
    packages = with pkgs; [
      nmap
      fd
      ripgrep
      htop
      btop
      lynx
      gnumake
    ];
  };

  programs.git = {
    enable = true;
    userName =  "Bjorn Martens";
    userEmail =  "bjorn@expeditious.nl";
  };

  home.stateVersion = "23.05";
}
