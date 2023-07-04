{ pkgs, ... }: {
  programs.home-manager.enable = true;

  home = {
    username = "bjornmartens";
    homeDirectory = "/Users/bjornmartens";
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "Hack Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "Hack Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "Hack Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "Hack Nerd Font";
          style = "Bold Italic";
        };
      };
    };
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      plenary-nvim
      nvim-treesitter.withAllGrammars
      { 
        plugin = neorg;
        type = "lua";
        config = ''
          require('neorg').setup {
            load = {
              ["core.defaults"] = {},
              ["core.dirman"] = {
                config = {
                  workspaces = {
                    home = "~/notes/home",
                  }
                }                
              }
            }
          }
        '';
      }
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

  programs.helix = {
    package = pkgs.helix;
    enable = true;
    languages = {
      language = [{ name = "rust"; }];
    };
    settings = {
      editor = {
        lsp.display-messages = true;
      };
    };
  };
  programs.ripgrep.enable = true;
  home.stateVersion = "23.05";
}
