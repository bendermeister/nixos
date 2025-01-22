test: ./configuration.nix ./flake.nix
	nixos-rebuild test --flake .
switch:
	nixos-rebuild switch --flake .
