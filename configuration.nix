{ config, pkgs, ... }:

let home-manager = builtins.fetchTarball {
  url = "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
  sha256 = "sha256:1pikl3ai9if1lp2zllxpdnp2krkgqsbrry6f9b4gsxh60jnamyy0";
}; in

{
  imports = [
    "${home-manager}/nixos"
  ];

  config = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    nixpkgs.config = {
      allowUnfree = true;
      allowBroken = false;
      cudaSupport = true;
    };

    networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

    time.timeZone = "Europe/Moscow";

    environment.systemPackages = with pkgs; [
      procps pmutils htop ncdu iotop lsof
      tree rlwrap pciutils usbutils psmisc pv
      unzip unrar atool p7zip
      mosh curl wget whois traceroute tcpdump nettools sshfs
      bind bridge-utils nmap
      mc ranger vim tmux less
      liquidprompt
      sublime
      fontconfig
      qemu virt-manager
      docker docker-compose
    ];

    security.sudo.wheelNeedsPassword = false;

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      setLdLibraryPath = true;
      extraPackages32 = [ ];
    };
    hardware.pulseaudio = {
      enable = true;
      support32Bit = true;
    };
    sound.enable = true;

    services.xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];
      libinput.enable = true;
      layout = "us,ru";
      xkbOptions = "grp:alt_shift_toggle,grp_led:scroll,compose:menu";
      xkbVariant = "qwerty";
      gdk-pixbuf.modulePackages = with pkgs; [ librsvg ];
      displayManager.lightdm.enable = true;
      desktopManager.xfce.enable = true;
    };

    console = {
      font = "cyr-sun16";
      keyMap = "ru";
    };

    i18n = {
      defaultLocale = "en_US.UTF-8";
    };

    fonts = {
      fontDir.enable = true;
      enableGhostscriptFonts = true;
      packages = with pkgs; [
        liberation_ttf
        anonymousPro
        dejavu_fonts
        powerline-fonts
        terminus_font
        source-code-pro
        freefont_ttf
      ];
    };

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.package = pkgs.qemu_kvm;
      };
    };
    services.spice-vdagentd.enable = true;

    virtualisation.docker = {
      enable = true;
      enableNvidia = true;
    };

    users.users = {
      root = {
        initialPassword = "root";
      };
      user = {
        isNormalUser = true;
        extraGroups = [ "wheel" ];
        initialPassword = "user";
      };
    };

    home-manager.users.user = ({ config, pkgs, lib, osConfig, ... }: {
      programs.home-manager.enable = true;
      home.packages = with pkgs; [ ];
      programs = {
        alacritty.enable = true;
        bash = {
          enable = true;
        };
        fzf.enable = true;
        git = {
          enable = true;
        };
        firefox = {
          enable = true;
        };
        chromium = {
          enable = true;
          extensions = [
            "cjpalhdlnbpafiamejdnhcphjbkeiagm"  # ublock
          ];
        };
      };
      home.stateVersion = "23.11";
    });

    system.stateVersion = "23.11";

  };

}
