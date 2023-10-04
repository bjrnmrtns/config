{ config, pkgs, inputs, ... }: {

  imports = [
#    ../../modules/yabai+skhd.nix
  ];
 
  programs.zsh.enable = true;

  home-manager =  {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.bjornmartens = import "${inputs.self}/users/bjornmartens";
    extraSpecialArgs = { 
      inherit inputs;
      headless = false;
    };
  };

#  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
#  environment.systemPackages = [ pkgs.rust-bin.stable.latest.complete ];

  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.bjornmartens = {
    name = "bjornmartens";
    home = "/Users/bjornmartens"; 
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;

    casks = [
      "obsidian"
    ];
  };
}
