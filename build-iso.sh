#!/usr/bin/env bash
nixos
nix build .#nixosConfigurations.iso.config.system.build.isoImage
