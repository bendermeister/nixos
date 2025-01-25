{pkgs, ...}: {
    imports = [
        ./nvim.nix
        ./general.nix
        ./zsh.nix
    ];

    home.pointerCursor = {
        name = "Vanilla-DMZ";
        package = pkgs.vanilla-dmz;
        x11.enable = true;
    };
}
