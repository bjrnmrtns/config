# Installation of NixOS

## Download the latest NixOS minimal iso
```
https://nixos.org/download.html
```

## Installing on qemu guest

### Create disk image
```
qemu-img create -f qcow2 nixos.qcow2 50g
```

### Start qemu box with 5555 forwarded
```
qemu-system-x86_64 -m 8G -smp 6 -cdrom nixos-minimal-22.11.4369.99fe1b87052-x86_64-linux.iso -drive file=nixos.qcow2,if=virtio -vga virtio -display default,show-cursor=on -usb -device usb-tablet -cpu host -machine type=q35,accel=hvf -net nic -net user,hostfwd=tcp::5555-:22
```

## Installing on pc
Something about creating a bootable usb with iso

## General installatioon
### Download scripts for installation
```
curl https://raw.githubusercontent.com/bjrnmrtns/nixos-config/master/installation/download.sh
```
```
./download.sh
```
Change the DISK variable in partition.sh if needed
```
./partition.sh
```
Generate ininitial configuration
```
sudo nixos-generate-config
```

Change the following line in configuration.nix the correct boot device used in partition.sh
```
boot.loader.gub.device = "/dev/vda";
```
Copy configuration
```
sudo cp configuration.nix /mnt/etc/nixos/
```

```
sudo nixos-install && sudo reboot
```

-- Add ssh key for user
```
ssh-keygen -t ed25519 -C "<email>"
```
- add public key to github


## Updating configuration after base installation
### Clone repo
```
cd ~
git clone git@github.com:bjrnmrtns/nixos-config.git
sudo rm -rf /etc/nixos/
export NIXOS_CONFIG=/home/bjorn/nixos-config/installation/configuration.nix
```

### Rebuilding the adapted configuration and take effect after reboot
```
sudo -E nixos-rebuild boot # -E is needed so exported variables can be used in sudo context
```

