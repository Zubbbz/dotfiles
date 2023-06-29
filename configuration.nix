# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
#fart
{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ### Tools ###
    # Browsers
      firefox
      ungoogled-chromium
    # YubiKey Stuff
      yubikey-manager-qt yubioath-flutter
    # Slicer
      prusa-slicer super-slicer-latest
    # Editors
      vscode-fhs
      neovim
    # Cli Tools
      killall
      btop
      neofetch
      wget
      ripgrep
      thefuck
      git
      nitrogen
      flameshot
      starship
      bat
      bitwarden-cli
    # Communications
      discord
      signal-desktop
    # RDP
      rustdesk
    # Files
      xfce.thunar
      dolphin
      pcmanfm
      p7zip
      ark
      unzip
      libarchive
    # Mullvad
      mullvad mullvad-vpn mullvad-browser
    # Tor
      tor-browser-bundle-bin

    ### Dev Tools ###
    # Python
      python311Full python311Packages.pip
    # Node
      nodejs_18
      nodePackages.typescript
      nodePackages.npm
      nodePackages.pnpm
      yarn
    # Lua
      lua luajit lua52Packages.lua
    # Rust
      rustup
    # Java
      zulu
      zulu8
      gradle
    # Nix LS
      nil
    # C/C++
      gcc
      cmake
    # Go
      go

    ### Audio/Graphsics/Video ###
    # FFmpeg
      ffmpeg ffmpegthumbnailer ffmpegthumbs
    # Recording
      obs-studio
    # Image Editors
      gimp
    # Content Players
      mpv
      plex-media-player
    # Audio Control
      pavucontrol
      qjackctl
      helvum
      bluez

    ### Gaming ##
    # Minecraft
      prismlauncher
    # Steam
      steam

    # Virtualization
      qemu
      qemu-utils
      OVMF
      seabios
      virt-manager
      libvirt

    # Desktop Experience
      alacritty
      tmux
      polkit_gnome
      i3
      bitwarden
  ];

  programs = {
    dconf = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
  };

  environment.etc = {
    "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
    '';
  };

  fonts.fonts = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
  ];

  virtualisation.libvirtd.enable = true;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  services = {
                                                          ###### Audio + BT ####
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber = {
        enable = true;
      };
    };
    blueman = {
      enable = true;
    };

                                                          ###### xserver #######
    xserver = {
      layout = "us";
      xkbVariant = "";
      enable = true;
      displayManager = {
        sddm.enable = true;
      };
      desktopManager = {
        xterm.enable = true;
        plasma5.enable = true;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu #application launcher most people use
          i3status # gives you the default i3 status bar
          i3lock #default i3 screen locker
          i3blocks #if you are planning on using i3blocks over i3status
          imagemagick
          rofi
          lxappearance
          moka-icon-theme
        ];
      };
    };

    # Mullvad                                                 ##### Mullvad ####
    mullvad-vpn = {
      enable = true;
    };

    # Enable CUPS to print documents.                         #### Printing ####
    printing = {
      enable = true;
    };
  };
                                                          ###### HARDWARE ######
  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
    pulseaudio = {
      extraConfig = "load-module module-switch-on-connect";
    };
  };
                                                          ###### BOOT ##########
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
    };
  };

                                                          ###### NETWORKING ####
  networking = {
    hostName = "nathan-laptop";
    hostId = "deadb33f";
    enableIPv6 = true;
    dhcpcd.enable = false;
    nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" ];
    wireguard.enable = true;

    wireless = {
      enable = false;
    };
    networkmanager = {
      enable = true;
      dns = "none";
    };

                                                          ###### FIREWALL ######
    firewall = {
      checkReversePath = "loose";
    };
  };
                                                          ###### TIME & LOCALE #
  time = {
    # Set your time zone.
    timeZone = "America/Detroit";
  };

  ## Locale
  i18n = {
    # Select internationalisation properties.
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };
                                                          ###### SECURITY ######
  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };

    rtkit = {
      enable = true;
    };

    polkit = {
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
              )
            )
          {
            return polkit.Result.YES;
          }
        })
      '';
      enable = true;
    };
  };

                                                          ###### SYSTEMD #######
  systemd = {
    # Authentication agent
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
  };
};
                                                          ###### USERS #########
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      nathan = {
        isNormalUser = true;
        description = "nathan";
        extraGroups = [ "networkmanager" "wheel" "libvirtd" "audio" ];
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
  system.autoUpgrade.enable = true;
}
