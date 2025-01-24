{pkgs, ...}: {
    home.username = "ben";
    home.homeDirectory = "/home/ben";
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;
}
