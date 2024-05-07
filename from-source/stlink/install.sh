#!/usr/bin/env bash


git clone https://github.com/stlink-org/stlink
cd stlink/
sudo make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=${HOME}/.local install
