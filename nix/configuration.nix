{ config, lib, pkgs, ... }:
{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports = [
      ./home
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jennifer";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Docker
  virtualisation.docker.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    #useXkbConfig = true; # use xkb.options in tty.
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bjorn = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" ];
    # Created using mkpasswd
    hashedPassword = "$y$j9T$1dyXKDTyGzdkserNs/vsh.$IYMLLznhPPNd3ynLoSXjlh/Uy.slR/U.8fnzMVcoLz3";
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  home-manager.users.bjorn = { lib, pkgs, ... }: {
    home.packages = with pkgs; [
        (pkgs.writeShellScriptBin "tmux-sessionizer" ''
            #!/usr/bin/env bash

            # tmux-sessionizer thanks to ThePrimeagen            

            if [[ $# -eq 1 ]]; then
                selected=$1
            else
                selected=$(find ~/projects ~/projects-np -mindepth 1 -maxdepth 1 -type d -not -path '*/.*' | fzf)
            fi
            
            if [[ -z $selected ]]; then
                exit 0
            fi
            
            selected_name=$(basename "$selected" | tr . _)
            tmux_running=$(pgrep tmux)
            
            if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
                tmux new-session -s $selected_name -c $selected
                exit 0
            fi
            
            if ! tmux has-session -t=$selected_name 2> /dev/null; then
                tmux new-session -ds $selected_name -c $selected
            fi
            
            tmux switch-client -t $selected_name
	'')
    ];

    programs.foot = {
        enable = true;
        settings = {
	   main = {
	       shell = "tmux";
	       font = "monospace:size=10";
	   };
        };
    };

    programs.qutebrowser = {
      enable = true;
    };

    programs.firefox = {
      enable = true;
    };

    programs.gpg = {
      enable = true;
    };

    programs.git = {
      enable = true;
      userEmail = "borjn@proton.me";
      userName = "Bjorn Martens";
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        plenary-nvim
      ];
    };

    accounts.email.accounts = {
      work = {
	primary = true;
        aerc.enable = true;
	realName = "Bjorn Martens";
	address = "bjorn@expeditious.nl";
	imap.host = "imap.transip.email";
	smtp.host = "smtp.transip.email";
	userName = "bjorn@expeditious.nl";
	passwordCommand = "pass mail/bjorn@expeditious.nl";
      };
    };

    programs.ripgrep = {
      enable = true;
    };

    programs.waybar = {
        enable = true;
	settings = {
            mainBar = {
                layer = "top";
                position = "top";
                height = 26;
                output = [
                  "eDP-1"
                ];
            
                modules-left = [ "custom/logo" "sway/workspaces" "sway/mode" ];
                modules-right = [ "sway/language" "clock" "battery" ];
                
                "custom/logo" = {
                  format = "";
                  tooltip = false;
                  on-click = ''bemenu-run --accept-single  -n -p "Launch" --hp 4 --hf "#ffffff" --sf "#ffffff" --tf "#ffffff" '';
                };
            
                "sway/workspaces" = {
                  disable-scroll = true;
                  all-outputs = true;
                  persistent_workspaces = {
                    "1" = []; 
                    "2" = [];
            	"3" = [];
            	"4" = [];
                  };
                  disable-click = true;
                };
            
                "sway/mode" = {
                  tooltip = false;
                };
                
                "sway/language" = {
                  format = "{shortDescription}";
                  tooltip = false;
                  on-click = ''swaymsg input "1:1:AT_Translated_Set_2_keyboard" xkb_switch_layout next'';
            
                };
            
                "clock" = {
                  interval = 60;
                  format = "{:%a %d/%m %I:%M}";
                };
            
                "battery" = {
                  tooltip = false;
                };

                "style" = ''
                    * {
                      border: none;
                      border-radius: 0;
                      padding: 0;
                      margin: 0;
                      font-size: 11px;
                    }
                  
                    window#waybar {
                      background: #292828;
                      color: #ffffff;
                    }
                    
                    #custom-logo {
                      font-size: 18px;
                      margin: 0;
                      margin-left: 7px;
                      margin-right: 12px;
                      padding: 0;
                      font-family: NotoSans Nerd Font Mono;
                    }
                    
                    #workspaces button {
                      margin-right: 10px;
                      color: #ffffff;
                    }
                    #workspaces button:hover, #workspaces button:active {
                      background-color: #292828;
                      color: #ffffff;
                    }
                    #workspaces button.focused {
                      background-color: #383737;
                    }
                  
                    #language {
                      margin-right: 7px;		
                    }
                  
                    #battery {
                      margin-left: 7px;
                      margin-right: 3px;
                    }
                '';
	    };
        };
    };

    programs.tmux = {
        enable = true;
	extraConfig =
	''
            set -ga terminal-overrides ",screen-256color*:Tc"
            set-option -g default-terminal "screen-256color"
            set -s escape-time 0
            
            unbind C-b
            set-option -g prefix C-a
            bind-key C-a send-prefix
            set -g status-style 'bg=#333333 fg=#5eacd3'
            
            bind r source-file ~/.config/tmux/tmux.conf
            set -g base-index 1
            set -g history-limit 10000
            
            set-window-option -g mode-keys vi
            bind -T copy-mode-vi v send-keys -X begin-selection
            bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
            
            # split pane rebinding
            bind \\ split-window -h
            bind - split-window -v
            
            # vim-like pane switching
            bind -r ^ last-window
            bind -r k select-pane -U
            bind -r j select-pane -D
            bind -r h select-pane -L
            bind -r l select-pane -R
            
            bind -r J neww -c "#{pane_current_path}" "[[ -e todo.md ]] && nvim todo.md || nvim ~/projects/personal/todo.md"
            bind -r P neww -c "#{pane_current_path}" "nvim ~/projects/personal/projects.md"
            
            # forget the find window.  That is for chumps
            bind-key -r f run-shell "tmux neww tmux-sessionizer"
	'';
    };

    programs.aerc = {
      enable = true;
      extraBinds = {
        global = {
          "<C-p>" = ":prev-tab<Enter>";
          "<C-n>" = ":next-tab<Enter>";
          "?" = ":help keys<Enter>";
        };

        messages = {
          "h" = ":prev-tab<Enter>";
          "l" = ":next-tab<Enter>";

          "j" = ":next<Enter>";
          "<Down>" = ":next<Enter>";
          "<C-d>" = ":next 50%<Enter>";
          "<C-f>" = ":next 100%<Enter>";
          "<PgDn>" = ":next 100%<Enter>";

          "k" = ":prev<Enter>";
          "<Up>" = ":prev<Enter>";
          "<C-u>" = ":prev 50%<Enter>";
          "<C-b>" = ":prev 100%<Enter>";
          "<PgUp>" = ":prev 100%<Enter>";
          "g" = ":select 0<Enter>";
          "G" = ":select -1<Enter>";

          "J" = ":next-folder<Enter>";
          "K" = ":prev-folder<Enter>";
          "H" = ":collapse-folder<Enter>";
          "L" = ":expand-folder<Enter>";

          "v" = ":mark -t<Enter>";
          "x" = ":mark -t<Enter>:next<Enter>";
          "V" = ":mark -v<Enter>";

          "T" = ":toggle-threads<Enter>";

          "<Enter>" = ":view<Enter>";
          "d" = ":prompt 'Really delete this message?' 'delete-message'<Enter>";
          "D" = ":delete<Enter>";
          "A" = ":archive flat<Enter>";

          "C" = ":compose<Enter>";

          "rr" = ":reply -a<Enter>";
          "rq" = ":reply -aq<Enter>";
          "Rr" = ":reply<Enter>";
          "Rq" = ":reply -q<Enter>";

          "c" = ":cf<space>";
          "$" = ":term<space>";
          "!" = ":term<space>";
          "|" = ":pipe<space>";

          "/" = ":search<space>";
          "\\" = ":filter<space>";
          "n" = ":next-result<Enter>";
          "N" = ":prev-result<Enter>";
          "<Esc>" = ":clear<Enter>";
        };

        "messages:folder=Drafts" = { "<Enter>" = ":recall<Enter>"; };

        view = {

          "/" = ":toggle-key-passthrough<Enter>/";
          "q" = ":close<Enter>";
          "O" = ":open<Enter>";
          "S" = ":save<space>";
          "|" = ":pipe<space>";
          "D" = ":delete<Enter>";
          "A" = ":archive flat<Enter>";

          "<C-l>" = ":open-link <space>";

          "f" = ":forward<Enter>";
          "rr" = ":reply -a<Enter>";
          "rq" = ":reply -aq<Enter>";
          "Rr" = ":reply<Enter>";
          "Rq" = ":reply -q<Enter>";

          "H" = ":toggle-headers<Enter>";
          "<C-k>" = ":prev-part<Enter>";
          "<C-j>" = ":next-part<Enter>";
          "J" = ":next<Enter>";
          "K" = ":prev<Enter>";
        };

        "view::passthrough" = {
          "$noinherit" = true;
          "$ex" = "<C-x>";
          "<Esc>" = ":toggle-key-passthrough<Enter>";
        };

        compose = {
          "$noinherit" = "true";
          "$ex" = "<C-x>";
          "<C-k>" = ":prev-field<Enter>";
          "<C-j>" = ":next-field<Enter>";
          "<A-p>" = ":switch-account -p<Enter>";
          "<A-n>" = ":switch-account -n<Enter>";
          "<tab>" = ":next-field<Enter>";
          "<C-p>" = ":prev-tab<Enter>";
          "<C-n>" = ":next-tab<Enter>";
        };

        "compose::editor" = {
          "$noinherit" = "true";
          "$ex" = "<C-x>";
          "<C-k>" = ":prev-field<Enter>";
          "<C-j>" = ":next-field<Enter>";
          "<C-p>" = ":prev-tab<Enter>";
          "<C-n>" = ":next-tab<Enter>";
        };

        "compose::review" = {
          "y" = ":send<Enter>";
          "n" = ":abort<Enter>";
          "p" = ":postpone<Enter>";
          "q" = ":choose -o d discard abort -o p postpone postpone<Enter>";
          "e" = ":edit<Enter>";
          "a" = ":attach<space>";
          "d" = ":detach<space>";
        };

        terminal = {
          "$noinherit" = "true";
          "$ex" = "<C-x>";

          "<C-p>" = ":prev-tab<Enter>";
          "<C-n>" = ":next-tab<Enter>";
        };
      };
      extraConfig = {
        general.unsafe-accounts-conf = true;
        ui = {
          this-day-time-format = ''"           15:04"'';
          this-year-time-format = "Mon Jan 02 15:04";
          timestamp-format = "2006-01-02 15:04";

          spinner = "[ ⡿ ],[ ⣟ ],[ ⣯ ],[ ⣷ ],[ ⣾ ],[ ⣽ ],[ ⣻ ],[ ⢿ ]";
          border-char-vertical = "┃";
          border-char-horizontal = "━";
        };
        viewer = { always-show-mime = true; };
        compose = { no-attachment-warning = "^[^>]*attach(ed|ment)"; };
        triggers = {
          email-received = ''exec notify-send "New email from %n" "%s"'';
        };
        filters = {
          "text/plain" = "colorize";
          "text/html" = "html";
          "text/calendar" = "calendar";
          "message/delivery-status" = "colorize";
          "message/rfc822" = "colorize";
          "image/*" = "${pkgs.catimg}/bin/catimg -";
        };
      };
      stylesets = {
        default = {
          "border.bg" = 0;
          "border.fg" = 7;
          "msglist_default.bg" = 0;
          "msglist_unread.fg" = 3;
          "msglist_unread.bold" = "true";
          "msglist_marked.bg" = 4;
          "dirlist_default.bg" = 0;
          "dirlist_unread.fg" = 3;
          "*.selected.reverse" = "toggle";
        };
      };
    };

    home.stateVersion = "24.05";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nixos-option # checking options for certain nix options
    gnumake
    pass
    pinentry-curses # being able to enter a passphrase for gpg in the terminal
    qrencode
    feh # image file reader
    evince # evince is for pdf reading
    # grim and slurp are for screenshots
    grim
    slurp
    fzf
    light # for setting brightness
    openscad # modelling

    pipewire
    pavucontrol       # GUI for managing sound
  ];

  services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 80 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
