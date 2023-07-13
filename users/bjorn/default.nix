{ pkgs, lib, inputs, headless ? true, ... }: {

  imports = [] ++ lib.optional (!headless) ./desktop.nix;
  
  home = {
    username = "bjorn";
    homeDirectory = "/home/bjorn";
  };

  programs.git = {
    enable = true;
    userName =  "Bjorn Martens";
    userEmail =  "bjorn@expeditious.nl";
  };

  home.stateVersion = "23.05";
}
