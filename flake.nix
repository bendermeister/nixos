{
    description = "System Configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    };


    outputs = { nixpkgs, ... }: {
        nixosConfigurations.bigbox = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./modules/bigbox/configuration.nix
                ./modules/bigbox/hardware-configuration.nix
                ./modules/common/common.nix
            ];
        };
    };
}
