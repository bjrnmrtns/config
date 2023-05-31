# Download/Format/Installing a NixOS
- Download iso e.g. latest NixOS (21.05)
```
https://nixos.org/download.html
```
# Start qemu box with 5555 forwarded
```
qemu-system-x86_64 -m 8G -smp 6 -cdrom nixos-minimal-22.11.4369.99fe1b87052-x86_64-linux.iso -drive file=nixos.qcow2,if=virtio -vga virtio -display default,show-cursor=on -usb -device usb-tablet -cpu host -machine type=q35,accel=hvf -net nic -net user,hostfwd=tcp::5555-:22
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

-- Add ssh key for user
```
ssh-keygen -t ed25519 -C "<email>"
```
- add key to github
- add <user-name> to sudoers file


```
sudo nixos-install
sudo reboot
```

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

