#!/usr/bin/env bash

# Run lsblk to change disk and make sure you use the right one as it is being formatted

DISK=vda

sudo parted /dev/${DISK} -- mklabel msdos
sudo parted /dev/${DISK} -- mkpart primary 1MiB -8GiB
sudo parted /dev/${DISK} -- mkpart primary linux-swap -8GiB 100%

sudo mkfs.ext4 -L nixos /dev/${DISK}1
sudo mkswap -L swap /dev/${DISK}2

sudo mount /dev/disk/by-label/nixos /mnt
sudo swapon /dev/${DISK}2
sudo nixos-generate-config --root /mnt

