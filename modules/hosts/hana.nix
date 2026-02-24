{self, ...}: {
  azalea.hosts.hana = {
    pkgs,
    config,
    lib,
    username,
    ...
  }: {
    imports = [
      self.azalea.users.zakei
      self.azalea.dots.zakei-cli
      self.azalea.dots.zakei-gui
      self.azalea.dots.zakei-niri

      self.azalea.profiles.default
      self.azalea.profiles.workstation
      self.azalea.profiles.niri
      self.azalea.modules.dolphin
      self.azalea.modules.cursors
      self.azalea.modules.btrfs
      self.azalea.modules.steam
      self.azalea.modules.nvidia
      self.azalea.modules.greetd-autostart
      #self.azalea.modules.silent-sddm
      self.azalea.modules.cups
    ];

    # info
    system.stateVersion = "26.05";
    networking.hostName = "hana";
    time.timeZone = "Asia/Yangon";
    nixpkgs.hostPlatform = "x86_64-linux";

    # zaphkiel opts
    zaphkiel = {
      data.wallpaper = self.packages.${pkgs.stdenv.hostPlatform.system}.images.corvus;
      secrets = {
        antonioPass = {
          file = self.paths.secrets + /hana-user.age;
          owner = "antonio";
        };
        tailAuth = {
          file = self.paths.secrets + /tailscale.age;
          owner = "antonio";
        };
        secret2 = {
          file = self.paths.secrets + /hana-access-token.age;
          owner = "antonio";
          mode = "0500";
          path = "/etc/nix/nix-access-token.conf";
        };
        recovery = {
          file = self.paths.secrets + /recovery.age;
          owner = "root";
          path = "/home/${username}/.config/keys/recovery.txt";
        };
        anilist = {
          file = self.paths.secrets + /anilist.age;
          owner = "antonio";
          path = "/home/${username}/.config/keys/anilist.txt";
        };
        ssh-hana = {
          file = self.paths.secrets + /ssh-hana.age;
          owner = "root";
          path = "/home/${username}/.config/keys/ssh-hana";
        };
      };
      # programs = {
      #   privoxy.forwards = [
      #     {
      #       domains = [
      #         ".donmai.us"
      #         ".yande.re"
      #         "www.zerochan.net"
      #       ];
      #     }
      #   ];
      #   shpool.users = [ "antonio" ];
      # };
      # graphics.intel.hwAccelDriver = "media-driver";
      services = {
        # caddy = {
        #   secretsFile = config.age.secrets.caddyEnv.path;
        #   tsplugin.enable = true;
        # };
        tailscale = {
          operator = "antonio";
          authFile = config.age.secrets.tailAuth.path;
        };
      };
    };

    # user stuff
    users.users."antonio".packages = [
      pkgs.vscodium
      self.packages.${pkgs.stdenv.hostPlatform.system}.mpv-wrapped
      pkgs.cava
    ];

    # hardware
    boot.kernelParams = ["i915.enable_guc=2"];
    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];

    # probably not required, but leaving it in for now
    services.fstrim.enable = true;
    # disabled autosuspend
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/33c9dfe4-1f00-4eca-8515-55330f66dd34";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/12a55073-227a-4f1a-a272-aeb49e34276c";
      fsType = "btrfs";
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/33c9dfe4-1f00-4eca-8515-55330f66dd34";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/719B-61DE";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/54a991e6-f06d-4de3-8eee-daf6f5671295"; }
    ];
  };
}
