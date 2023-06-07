{ pkgs, ... }: {
  home.username = "bjorn";
  home.homeDirectory = "/home/bjorn";
  home.packages = [
    pkgs.git
    pkgs.nmap
  ];
  programs.git = {
    enable = true;
    userName =  "Bjorn Martens";
    userEmail =  "bjorn@expeditious.nl";
  };
  home.stateVersion = "23.05";
  programs.home-manager.enable = true;
}
