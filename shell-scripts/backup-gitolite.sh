#!/usr/bin/env bash

git clone --mirror ssh://bjorn@mcfly/bjorn/nixos-secrets
cd nixos-secrets
git bundle create ../nixos-secrets.bundle --all 
