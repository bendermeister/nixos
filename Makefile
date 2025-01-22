deploy: configuration.nix
	cp ./configuration.nix /etc/nixos/configuration.nix
	nixos-rebuild switch
