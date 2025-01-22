{ config, lib, pkgs, ... }:

{
    imports = [ 
        ./hardware-configuration.nix
    ];
    networking.hostName = "bigbox";
    system.stateVersion = "24.11";
}

