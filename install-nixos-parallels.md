# Download/Format/Installing a NixOS
- Download iso e.g. latest NixOS (21.05)
```
https://nixos.org/download.html
```
- In parallels choose to install from iso (but say that it is a Ubuntu)
- Let the system start and it will automatically log in
- Open a terminal
- Partition drive (UEFI)
```
sudo parted /dev/sda -- mklabel gpt
sudo parted /dev/sda -- mkpart primary 512MiB -8GiB
sudo parted /dev/sda -- mkpart primary linux-swap -8GiB 100%
sudo parted /dev/sda -- mkpart ESP fat32 1MiB 512MiB
```
- Partition drive (Legacy)
```
sudo parted /dev/sda -- mklabel msdos
sudo parted /dev/sda -- mkpart primary 1MiB -8GiB
sudo parted /dev/sda -- mkpart primary linux-swap -8GiB 100%
```
- Format drive (UEFI)
```
sudo mkfs.ext4 -L nixos /dev/sda1
sudo mkswap -L swap /dev/sda2
sudo mkfs.fat -F 32 -n boot /dev/sda3
```
- Format drive (Legacy Boot)
```
sudo mkfs.ext4 -L nixos /dev/sda1
sudo mkswap -L swap /dev/sda2
```
- Mounting and configuration (UEFI)
```
sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot
sudo swapon /dev/sda2
sudo nixos-generate-config --root /mnt
```
- Mounting and configuration (Legacy Boot)
```
sudo mount /dev/disk/by-label/nixos /mnt
sudo swapon /dev/sda2
sudo nixos-generate-config --root /mnt
```
Now you can view the configuration in /mnt/etc/nixos
```
cat /mnt/etc/nixos/configuration.nix
cat /mnt/etc/nixos/hardware-configuration.nix
```
Now adapt the configuration (Legacy Boot)
Add the lines:
```
boot.loader.gub.device = "/dev/sda";
-- Installation
Add git/neovim/wget/firefox as system packages to configuration.nix
```
environment.systemPackage = with pkgs; [
  neovim
  git
  wget
  firefox
];
```
```
sudo nixos-install
sudo reboot
```

-- Add user
```
useradd -c "<first-name last-name>" -m "<username>"
passwd "<username>"
su <username>
ssh-keygen -t ed25519 -C "<email>"
```
- add key to github
- add <user-name> to sudoers file

## Get configuration.nix from github
```
mkdir ~/projects
git clone git@github.com:bjrnmrtns/system-installation.git
sudo rm -rf /etc/nixos/
export NIXOS_CONFIG=/home/bjorn/projects/system-installation/nixos/hosts/ironside.nix
```

## Rebuilding the adapted configuration and take effect after reboot
```
sudo -E nixos-rebuild boot # -E is needed so exported variables can be used in sudo context
```
