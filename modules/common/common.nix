{ config, pkgs, ... }:
{
    boot.loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
    };

    nixpkgs.config.allowUnfree = true;

    time.timeZone = "Europe/Vienna";

    i18n.defaultLocale = "en_US.UTF-8";
    console = {
        font = "Lat2-Terminus16";
        useXkbConfig = true; 
    };

    users.users.ben = {
        isNormalUser = true;
        extraGroups = [ "wheel" ]; 
    };

    security.sudo = {
        enable = true;
        wheelNeedsPassword = false;
    };

    # Xorg config
    services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        windowManager.dwm = {
            enable = true;
            package = pkgs.dwm.overrideAttrs {
                src = ./dwm;
            };
        };
        xkb = {
            layout = "us";
            options = "caps:swapescape";
        };
    };

    # Sound
    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    environment = {
        variables =  {
            EDITOR = "nvim";
        };
        interactiveShellInit = ''
            alias ls='eza -l'
            alias ll='eza -la'
        '';
    };

    environment.systemPackages = with pkgs; [
        neovim 
        wget
        git
        home-manager
        nodejs
        openvpn
        fastfetch
        dmenu
        librewolf
        discord
        openssh
        (st.overrideAttrs (oldAttrs: {
            src = ./st;
        }))
        tree-sitter
        eza
        clang
        cargo
        gnumake
        gopls
        rust-analyzer
        lua-language-server
        nixd
    ];


    nix = {
        settings.experimental-features = [ "nix-command" "flakes" ];

        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };
}
