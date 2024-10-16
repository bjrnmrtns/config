{ config, lib, pkgs, ... }:
{
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

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

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  home-manager.users.bjorn = { pkgs, ... }: {

    home.packages = with pkgs; [
    ];

    programs.tmux = {
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
    nixos-option
    gnumake
    pass
    pinentry-curses
    qrencode
    feh
  ];

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
