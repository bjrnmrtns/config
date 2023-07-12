HOSTNAME = $(shell hostname -s)

ifndef HOSTNAME
  $(error hostname unknown)
endif

switch:
	darwin-rebuild switch --flake .#${HOSTNAME} -L

#!/usr/bin/env bash
#nix build .#nixosConfigurations.iso.config.system.build.isoImage
#!/usr/bin/env bash
#darwin-rebuild switch --flake .#jennifer
#!/usr/bin/env bash
#sudo nixos-rebuild switch --flake '.#mcfly'
