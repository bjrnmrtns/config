# Installation of NixOS

## Directories in this repo

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
Create usb stick with iso
```
sudo dd if=<iso-file-name> of=<usb-stick-dev-file-name> bs=4M
```

## General installation (most of it is about installing on a real system with uefi boot)
### Download scripts for installation
```
curl https://raw.githubusercontent.com/bjrnmrtns/nixos-config/master/download.sh
```
```
./download.sh
```
Change the DISK variable in partition.sh if needed
```
./partition-uefi-mount-and-nixos-generate-config.sh

```
Copy configuration
```
sudo cp configuration.nix /mnt/etc/nixos/
```

```
sudo nixos-install && sudo nixos-rebuild switch && sudo reboot
```

-- Add ssh key for user
```
ssh-keygen -t ed25519 -C "<email>"
```
- add public key to github
- add public key to gitolite config


## Updating configuration after base installation
### Clone repo
```
cd ~
git clone git@github.com:bjrnmrtns/nixos-config.git
sudo cp /etc/nixos/hardware-configuration ./
git add -u && git commit -m "Update hardware-configuration" && git push
sudo rm -rf /etc/nixos/
sudo ln -s ${PWD} /etc/nixos
```

### From now on updating to new configuration using flakes is done with nixos-rebuild switch 
```
sudo nixos-rebuild switch
```

## Using gitolite
Adding users is done by adding a <username>@<does not matter hostname>.pub file of ssh to the gitolite-admin/conf/keydir directory.
However you always use the gitolite user to clone. E.g. git clone ssh://gitolite@<ip-address>/<repo-name>.
If your key is in conf/keydir you are able to clone.

## Setup nix on MacOS

### Bootstrap
```
curl -L https://nixos.org/nix/install | sh
nix build --extra-experimental-features "nix-command flakes" .#darwinConfigurations.jennifer.system
./result/sw/bin/darwin-rebuild switch --flake .#jennifer
rm -rf ./result
```

### Updating config
After every config change run
darwin-rebuild switch --flake .#jennifer

## Setup Ubuntu system
xargs sudo apt-get --no-install-recommends -y install < packages.txt
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install zellij
