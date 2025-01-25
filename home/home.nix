{pkgs, ...}: {
    imports = [
        ./nvim.nix
        ./general.nix
    ];

    home.pointerCursor = {
        name = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
        size = 32;
        x11.enable = true;
    };
}
