{ config, lib, pkgs, ... }:

{
    imports = [ 
        ./hardware-configuration.nix
    ];

    boot.loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
    };

    # General System Configuration
    networking.hostName = "bigbox";
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

    environment = {
        variables =  {
            EDITOR = "nvim";
        };
        interactiveShellInit = ''
            alias ls='eza -l'
            alias ll='eza -la'
        '';
    };


    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        neovim 
        wget
        git
        nodejs
        fastfetch
        librewolf
        dmenu
        (st.overrideAttrs (oldAttrs: {
            src = ./st;
        }))
        tree-sitter
        discord
        eza
        clang
        cargo
        gnumake
        gopls
        rust-analyzer
        lua-language-server
        nixd
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];


# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# Copy the NixOS configuration file and link it from the resulting system
# (/run/current-system/configuration.nix). This is useful in case you
# accidentally delete configuration.nix.
# system.copySystemConfiguration = true;

# This option defines the first version of NixOS you have installed on this particular machine,
# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
#
# Most users should NEVER change this value after the initial install, for any reason,
# even if you've upgraded your system to a new NixOS release.
#
# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
# so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
# to actually do that.
#
# This value being lower than the current NixOS release does NOT mean your system is
# out of date, out of support, or vulnerable.
#
# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
# and migrated your data accordingly.
#
# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "24.11"; # Did you read the comment?
}

