# Installation of Ubuntu

## Directories in this repo
- ./nix is a nix repo with a flake.nix
- ./dotfiles contains the dotfiles
- ./docker contains docker configurations for certain applications
- ./from-source contains applications which I built from source
- ./packages.txt contains all the packages needed to be installed on an ubuntu system
- ./wireguard contains wireguard setup on delorean 

## Download the latest Ubuntu iso and create usb for installing on pc
Create usb stick with iso
```
sudo dd if=<iso-file-name> of=<usb-stick-dev-file-name> bs=4M
```

## Get this configuration from github.com/bjrnmrtns/config

-- Add ssh key for user
```
ssh-keygen -t ed25519 -C "<email>"
```
- add public key to github

-- Clone this repo to ~/projects

-- Add the following line to ~/.bashrc
```
[[ -r ~/projects/config/dotfiles/bashrc-extra ]] && source ~/projects/config/dotfiles/bashrc-extra
```

## Installation of packages
After sourcing bash
run:
```
update
```
Add packages if needed by typing:
```
packages
```

Install newest version for some packages from source.
See this repo ```from-source``` directory.

Install rust:
```
curl https://sh.rustup.rs -sSf | sh
```

## Hosts
proxmox -> mcfly
all round server -> doc
vpn server -> delorean
laptop -> jennifer
desktop linux -> delorean (not good, same name as vpn server)

## Cleaning
Rust:
~/.cargo ~/.rustup

