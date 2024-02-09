#!/usr/bin/env bash

# config links
ln -s $(readlink -f nvim) ${HOME}/.config/nvim 
ln -s $(readlink -f sway) ${HOME}/.config/sway
ln -s $(readlink -f waybar) ${HOME}/.config/waybar
ln -s $(readlink -f gitconfig) ${HOME}/.gitconfig
ln -s $(readlink -f tmux.conf) ${HOME}/.tmux.conf
ln -s $(readlink -f foot) ${HOME}/.config/foot

