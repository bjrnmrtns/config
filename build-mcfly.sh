#!/usr/bin/env bash
sudo nixos-rebuild switch --flake '.#mcfly' --show-trace
