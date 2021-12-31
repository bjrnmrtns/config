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
```
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


# Making a bootable linux usb-stick from MacOS

1. Download iso e.g. latest Ubuntu Mate
2. Insert usb stick
3. Run: diskutil list
4. Look for the correct drive of the USB stick, e.g. /dev/disk3 (be carefull, you don't want to overwrite the MacOS partition)
5. If the disk is mounted, unmount it with diskutility. You do not want to eject it.
6. Use dd (like on linux) for creating the USB stick.
7. Run: sudo dd if=ubuntu.iso of=/dev/disk3 bs=4M
8. Make sure the other system will boot from the USB stick.
9. Insert USB stick.
10. Boot system.
11. Start installation. When partitioning make sure you create a UEFI partition.
12. sudo apt-get install git tmux neovim zsh rxvt-unicode steam-installer
13. add ssh key to github
14. git clone git@github.com:bjrnmrtns/nixos-config.git
15. git clone git@github.com:bjrnmrtns/dotfiles.git
16. set git username and email
16. ~/projects/dotfiles/setup-linux.sh
17. set capslock as ctrl
18. logout
19. start ./steam
20. enable Steam -> Settings -> Steam Play -> Steam Play for all titles

## fix assetto corsa on steam
1. sudo apt-get install python3-pip python3-setuptools python3-venv pipx winetricks
2. pipx install protontricks
3. protontricks-desktop-install
4. pipx upgrade protontricks
5. Set proton version to proton 5.0-10
6. protontricks 244210 dotnet472


# Making a bootable windows usb-stick from MacOS

1. Download iso e.g. Windows 10 Pro 
2. Insert usb stick
3. Run: diskutil list
4. Look for the correct drive of the USB stick, e.g. /dev/disk3 (be carefull, you don't want to overwrite the MacOS partition)
5. diskutil eraseDisk MS-DOS "WIN10" GPT /dev/disk3
6. if step 5 fails Run: diskutil eraseDisk MS-DOS "WIN10" MBR /dev/disk3
7. hdiutil mount ~/Downloads/win10.iso
8. rsync -vha --exclude=sources/install.wim /Volumes/CCCOMA_X64FRE_EN-US_DV9/ /Volumes/WIN10
9. brew install wimlib
10. mkdir /Volumes/WIN10/sources
11. wimlib-imagex split /Volumes/CCCOMA_X64FRE_EN-US_DV9/sources/install.wim /Volumes/WIN10/sources/install.swm 4000
12. eject stick
13. Insert in other machine.
14. Boot from partition 2, to install windows.
15. At the start of installation press shift F10
16. Run: diskpart
17. Run: list disk
18. Run: select disk 0 // look for the correct disk
19. convert gpt
20. Start windows installation


