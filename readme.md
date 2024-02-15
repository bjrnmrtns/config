# Installation of Ubuntu

## Directories in this repo
- ./ is a nix repo with a flake.nix
- ./dotfiles contains the dotfiles
- ./docker contains docker configurations for certain applications
- ./from-source contains applications which I built from source
- ./packages.txt contains all the packages needed to be installed on an ubuntu system

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

## Cleaning
Rust:
~/.cargo ~/.rustup

