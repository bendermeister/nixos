{
    description = "System Configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

        home-manager = {
          url = "github:nix-community/home-manager";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    };


    # outputs = { self, nixpkgs, home-manager, ... }: {
    # };

    outputs = { nixpkgs, home-manager, ... }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        homeConfigurations."ben" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [ 
                ./home.nix 
            ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
        };

        nixosConfigurations.bigbox = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./configuration.nix
            ];
        };
    };
}
