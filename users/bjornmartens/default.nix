{ pkgs, lib, inputs, headless ? true, ... }: {

  imports = [
    ../modules/neovim.nix
    ../modules/helix.nix
  ] ++ lib.optional (!headless) ./desktop.nix;

  programs.home-manager.enable = true;

  home = {
    username = "bjornmartens";
    homeDirectory = "/Users/bjornmartens";
    packages = with pkgs; [
      nmap
      fd
      ripgrep
      htop
      btop
      lynx
      jq
      tmux
      p7zip
      unrar
    ];
  };

  programs.git = {
    enable = true;
    userName =  "Bjorn Martens";
    userEmail =  "bjorn@expeditious.nl";
  };
  programs.zellij = {
    package = pkgs.zellij;
    enable = true;
  };
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
  };
  programs.nushell = {
    enable = true;    
    configFile = { text = ''
        let $config = {
          filesize_metric: false
          table_mode: rounded
          use_ls_colors: true
        }
      '';
    };
    envFile = { text = ''
      '';
    };
    shellAliases = {
      gg = "git status";
      ebshell = "/Applications/EekBoek.app/Contents/MacOS/ebshell";
      ebi = "/Applications/EekBoek.app/Contents/MacOS/ebshell --init";
      ebjaareinde = "/Applications/EekBoek.app/Contents/MacOS/ebshell --command jaareinde --boekjaar=2023";
      ebbalans = "/Applications/EekBoek.app/Contents/MacOS/ebshell --comand balans";
      cdnixcfg = "cd ~/projects/nixcfg";
      cdaccounting = "cd ~/Documents/expeditious/Accounting/eekboek-2023";
      cdinvoices = "cd ~/Documents/expeditious/Invoices/2023";
      cdhelp = ''echo "cdnixcfg cdaccounting cdinvoices"'';
    };
  };

  programs.ripgrep.enable = true;
  home.stateVersion = "23.05";
}
