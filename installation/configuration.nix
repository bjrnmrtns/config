{ config, pkgs, ... }:

{
  imports = [
    ./qemu-guest-hc.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";

  networking.hostName = "mcfly"; # Define your hostname.
  
  time.timeZone = "Europe/Amsterdam";

  services.openssh.enable = true;

  security.sudo.wheelNeedsPassword = false;
  
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;

  users.users.bjorn = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    packages = with pkgs; [
      git
      firefox
    ];
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDh1OpvdLU7rKC7Law6lvtgQIXViQKq0+xgPT1RI18UnowY1kn80+XU5SVn0NJqGhdv+B4MS73D2mFqqwPyJKrJyAusZmBA6wkQxnJDULlpLyB1Ot7mFZ9qDMV/3PdS3Bwp+UhwsI456u7zNOUjpYwwA5w4wym1w6myT3aP1JdD3kegnzeFExZN4QS96pJcW1Wzs/oDxVKkItMcEyz1ZZC6pz92queljdoR4R5hn0AK9JuxAYXo7u4pD1XhO9U0OQj9jKLdp3lu5s7wBzZ/qUwo4wVcdg8RgV5n56tu+hqm7t3klhx/4sIBjc6YNUOdfa6zBESmBmsvKT2/RPeI+9V76GOH//rKv4W6UQrr4dqQvu0j241dzlLpKkenJ7kaAMQwMhre9Rbo+h572ctvuaJrLfoRNVJnZf6+/yd9KbvwpSXGxHBe1+2yHspTSp5GU1A5ck8r32oUZmxQnDTRWgtmyqGAZsGm9VsPHFrg+yVKExGgN4dwNtkSevVH6L4Pr9TERf4PABtDr7krsD7op5cfJuzonEvAX1kSMQfhchKCE834OtAiucFLBNy5D5OlSJY4Djv700jNm5jFTBj0T5GUxviG6yFvnqRF0zeZO1q3Jr46iEng0Iyj/4/OkKT7rThjKji7ZCz8pSuoR7E6vqWnev/8nimKogDNsU2HciMhsw== bjorn@expeditious.nl"];
  };

  system.stateVersion = "22.11";
}