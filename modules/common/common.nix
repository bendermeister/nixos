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

    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-emoji
        noto-fonts-extra
    ];

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

    programs.steam = {
        enable = true;
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
        pulsemixer
        wget
        git
        home-manager
        nodejs
        xclip
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
        gnumake
        xclip
        spotify
        gopls
        rust-analyzer
        cargo
        xclip
        ksnip
        lua-language-server
        gopls
        nixd
        rnote
        signal-desktop
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
