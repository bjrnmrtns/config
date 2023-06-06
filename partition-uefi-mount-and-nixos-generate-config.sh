#!/usr/bin/env bash

# Run lsblk to change disk and make sure you use the right one as it is being formatted

DISK=vda

sudo parted /dev/${DISK} -- mklabel gpt
sudo parted /dev/${DISK} -- mkpart primary 512MiB -8GiB
sudo parted /dev/${DISK} -- mkpart primary linux-swap -8GiB 100%
sudo parted /dev/${DISK} -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/${DISK} -- set 3 esp on

sudo mkfs.ext4 -L nixos /dev/${DISK}p1
sudo mkswap -L swap /dev/${DISK}p2
sudo mkfs.fat -F 32 -n boot /dev/${DISK}p3

sudo mount /dev/disk/by-label/nixos /mnt
sudo mkdir -p /mnt/boot
sudo mount /dev/disk/by-label/boot /mnt/boot
sudo swapon /dev/${DISK}p2
sudo nixos-generate-config --root /mnt


