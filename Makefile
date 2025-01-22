switch: test
	nixos-rebuild switch --flake .
test:
	nixos-rebuild test --flake .

.PHONY: test switch
