test:
	nixos-rebuild test --flake .
switch:
	nixos-rebuild switch --flake .

.PHONY: test switch
