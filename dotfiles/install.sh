#!/usr/bin/env bash

ln -s $(readlink -f nvim) ${HOME}/.config/nvim 
ln -s $(readlink -f sway) ${HOME}/.config/sway
ln -s $(readlink -f waybar) ${HOME}/.config/waybar
ln -s $(readlink -f gitconfig) ${HOME}/.gitconfig
