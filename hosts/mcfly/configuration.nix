{ agenix, config, pkgs, secrets, ... }:

{
  imports = [
    ./hardware-configuration.nix
    agenix.nixosModules.default
    ../../modules/gitolite.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "mcfly";
  
  time.timeZone = "Europe/Amsterdam";

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;

  users.users.bjorn = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = ["ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDh1OpvdLU7rKC7Law6lvtgQIXViQKq0+xgPT1RI18UnowY1kn80+XU5SVn0NJqGhdv+B4MS73D2mFqqwPyJKrJyAusZmBA6wkQxnJDULlpLyB1Ot7mFZ9qDMV/3PdS3Bwp+UhwsI456u7zNOUjpYwwA5w4wym1w6myT3aP1JdD3kegnzeFExZN4QS96pJcW1Wzs/oDxVKkItMcEyz1ZZC6pz92queljdoR4R5hn0AK9JuxAYXo7u4pD1XhO9U0OQj9jKLdp3lu5s7wBzZ/qUwo4wVcdg8RgV5n56tu+hqm7t3klhx/4sIBjc6YNUOdfa6zBESmBmsvKT2/RPeI+9V76GOH//rKv4W6UQrr4dqQvu0j241dzlLpKkenJ7kaAMQwMhre9Rbo+h572ctvuaJrLfoRNVJnZf6+/yd9KbvwpSXGxHBe1+2yHspTSp5GU1A5ck8r32oUZmxQnDTRWgtmyqGAZsGm9VsPHFrg+yVKExGgN4dwNtkSevVH6L4Pr9TERf4PABtDr7krsD7op5cfJuzonEvAX1kSMQfhchKCE834OtAiucFLBNy5D5OlSJY4Djv700jNm5jFTBj0T5GUxviG6yFvnqRF0zeZO1q3Jr46iEng0Iyj/4/OkKT7rThjKji7ZCz8pSuoR7E6vqWnev/8nimKogDNsU2HciMhsw== bjorn@expeditious.nl" "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDs5NvuRQP1rBKiBIr3jHfc9NeGlccwsNbyxiwzvEr/Ta+mOD7uc9l4GbHZ8BFuCm3lsv4hjtDfXhBC3D6deHvzRjYWRkMMV6Yz9K+AG7cGBqdnGeOgqOfiHobxtu0bknAX8AR6iergSXYpVp+oeDyopsNLwvQEdMFYqp4YrFSmKG3nc1fsuC4ZJFwdkNbKjRulMwPtTjbHwc+Lu2om/A39eUznK59KqRIbi8BzVBXb/MHH+HP6Vs/LA6wNcKk6zQHHk2P5fz6EX2AweiE67tQKDDI5Ly4GV4BhRCu1WYA/A7QYEyYdknjiWuRIgq5dQL9j/vH6sJdidUOgsiyI27V/ypWTOxPlpza6rb+O4izYVYLeVGW/Np5NffuJjQmu53qM0gxK3hK8ByhqUuCJgtj2V8/wUHRNFxS0OOfoAKSYyUxUshdOrMEvgwZN9BbRX0aFUusVwVmAStzxPaxUDH1qLisDovQrnf6XlvDxrzLoA3q9+ZTzOP5Qk2YBuEOqdCU= bmarten1@thinkpad" "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFDl2Q6uuIdgeFU24JDj19YzTufS44HUqNDY+mdsmh04 bjorn@mcfly"];
  };

  environment.systemPackages = with pkgs; [
    agenix.packages.${system}.default
  ];

  system.stateVersion = "23.05";
}
