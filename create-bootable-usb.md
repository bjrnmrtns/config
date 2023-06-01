# Howto make bootable usb sticks

## Making a bootable linux usb-stick from MacOS

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

## Making a bootable windows usb-stick from MacOS

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


