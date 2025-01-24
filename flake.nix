{
    description = "bendermeister system configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { nixpkgs, home-manager, ... }: 
    let
        system = "x86_64-linux";
    in
    {
        nixosConfigurations = {
            bigbox = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    ./modules/bigbox/configuration.nix
                    ./modules/bigbox/hardware-configuration.nix
                    ./modules/common/common.nix


                    home-manager.nixosModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.ben = import ./home/home.nix;
                    }
                ];
            };
        };
    };
}
