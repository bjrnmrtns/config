# Download/Format/Installing a NixOS
- Download iso e.g. latest NixOS (21.05)
```
https://nixos.org/download.html
```
Execute  ``installation/partition.sh

Change the following line to the correct boot device used in partition.sh
```
boot.loader.gub.device = "/dev/vda";
```
Copy configuration
```
cp installation/configuration.nix /mnt/etc/nixos/
```

```
sudo nixos-install
sudo reboot
```

# Start qemu box with 5555 forwarded
qemu-system-x86_64 -m 8G -smp 6 -cdrom nixos-minimal-22.11.4369.99fe1b87052-x86_64-linux.iso -drive file=nixos.qcow2,if=virtio -vga virtio -display default,show-cursor=on -usb -device usb-tablet -cpu host -machine type=q35,accel=hvf -net nic -net user,hostfwd=tcp::5555-:22

-- Add ssh key for user
```
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


