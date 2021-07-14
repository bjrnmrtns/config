{ config, pkgs, options, ... }:

let home-manager = builtins.fetchGit
{
  url = "https://github.com/nix-community/home-manager.git";
  rev = "35a24648d155843a4d162de98c17b1afd5db51e4";
  ref = "release-21.05";
};
in
{
  imports = [
    ../modules/settings.nix
    (import "${home-manager}/nixos")
  ];

  nixpkgs.config = import ../config/nixpkgs.nix;

  time.timeZone = "Europe/Amsterdam";

  environment.variables.EDITOR = "nvim";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  environment.pathsToLink = ["/libexec"];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
	i3blocks
      ];
    };


  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  };
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    htop
    ethtool
    tcpdump
    conntrack-tools
    timescaledb
    nftables
    qemu
    ispell
    git
  ];

  fonts.fonts = with pkgs; [
    nerdfonts
  ];

  virtualisation.docker.enable = true;

  security.sudo.wheelNeedsPassword = false;

  users.users.${config.settings.username} = {
    isNormalUser = true;
    createHome = true;
    home = "/home/${config.settings.username}";
    description = "${config.settings.name}";
    extraGroups = [ "networkmanager" "docker" "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
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
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  home-manager.users.${config.settings.username} = import ../config/home.nix;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

