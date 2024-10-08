({ agenix, lib, pkgs,  ... }: {
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = "experimental-features = nix-command flakes recursive-nix";
  };

  networking = {
    networkmanager.enable = true;
    wireless.enable = lib.mkForce false;
    # ^because WPA Supplicant cannot run with NetworkManager
  };

  environment.systemPackages = with pkgs; [
    age agenix
    curl git neovim tmux
  ];
})
