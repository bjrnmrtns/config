{ agenix, config, pkgs, secrets, ... }:

{
  imports = [
    ../../modules/programs.nix
    ../../modules/agenix.nix
  ];

  # Use the GRUB 2 boot loader.

  networking.hostName = "jennifer";
  
  time.timeZone = "Europe/Amsterdam";

  security.sudo.wheelNeedsPassword = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;

  system.stateVersion = "23.05";
}
