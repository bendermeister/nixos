{
    description = "System Configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    };

    outputs = { self, nixpkgs, ... }: {
        nixosConfigurations.bigbox = nixpkgs.lib.nixosSystem {
            allowUnfree = true;
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
            ];
        };
    };
}
