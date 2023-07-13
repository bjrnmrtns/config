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
  };

  programs.ripgrep.enable = true;
  home.stateVersion = "23.05";
}
