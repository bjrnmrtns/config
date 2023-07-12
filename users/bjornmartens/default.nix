{ pkgs, lib, inputs, headless ? true, ... }: {

  imports = [] ++ lib.optional (!headless) ./desktop.nix;

  programs.home-manager.enable = true;

  home = {
    username = "bjornmartens";
    homeDirectory = "/Users/bjornmartens";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      plenary-nvim
      nvim-treesitter.withAllGrammars
      { 
        plugin = neorg;
        type = "lua";
        config = ''
-- # key mappings
function keymap(mode, lhs, rhs, new_opts)
  -- Default keymappings silent = true -> the command is not shown in status bar
  -- remap = true -> recursively remap keys
  local default_opts = { remap = true, silent = true }
  local merged_opts = vim.tbl_deep_extend('force', default_opts, new_opts)
  vim.keymap.set(mode, lhs, rhs, merged_opts)
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "
keymap("", "<Space>", "<Nop>", {})

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  }
}

require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.keybinds"] = {
      config = {
        default_keybinds = true,
      },
    },
    ["core.dirman"] = {
      config = {
        workspaces = {
          home = "~/notes/home",
        },
        index = "index.norg",
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
