HOSTNAME = $(shell hostname -s)
UNAME_S = $(shell uname -s)

ifeq ($(UNAME_S), Linux)
    REBUILD = sudo nixos-rebuild
else ifeq ($(UNAME_S), Darwin)
    REBUILD = darwin-rebuild
else
  $(error Operating System unknown)
endif

ifndef HOSTNAME
  $(error Hostname unknown)
endif

switch:
	$(REBUILD) switch --flake .#${HOSTNAME} -L

#!/usr/bin/env bash
#nix build .#nixosConfigurations.iso.config.system.build.isoImage
#!/usr/bin/env bash
#darwin-rebuild switch --flake .#jennifer
#!/usr/bin/env bash
#sudo nixos-rebuild switch --flake '.#mcfly'
