{self, ...}: {
  azalea.hosts.kagura = {
    pkgs,
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
      self.azalea.modules.intel
      self.azalea.modules.nvidia
      self.azelea.modules.mpv
      # self.azalea.modules.greetd-autostart
      self.azalea.modules.silent-sddm
      self.azalea.modules.cups
      self.azalea.modules.openssh
    ];

    # info
    system.stateVersion = "26.05";
    networking.hostName = "kagura";
    time.timeZone = "Asia/Yangon";
    nixpkgs.hostPlatform = "x86_64-linux";
    services.xserver.videoDrivers = [
      "modesetting"
      "nvidia"
    ];
    # zaphkiel opts
    zaphkiel = {
      data.wallpaper = self.packages.${pkgs.stdenv.hostPlatform.system}.images.corvus;
      graphics.intel.hwAccelDriver = "media-driver";
      graphics.nvidia = {
        hybrid = {
          enable = true;
          igpu.vendor = "intel";
          igpu.port = "PCI:0:2:0";
          dgpu.port = "PCI:1:0:0";
        };
      };
      secrets = {
        antonioPass = {
          file = self.paths.secrets + /kagura-user.age;
          owner = "antonio";
        };
        secret2 = {
          file = self.paths.secrets + /kagura-access-token.age;
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
        ssh-kagura = {
          file = self.paths.secrets + /ssh-kagura.age;
          owner = "root";
          path = "home/${username}/.config/keys/ssh-kagura";
        };
      };
    };

    # user stuff
    users.users."antonio".packages = [
      pkgs.vscodium
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
    powerManagement.cpuFreqGovernor = "performance";
    # probably not required, but leaving it in for now
    services.fstrim.enable = true;
    # disabled autosuspend

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/8d869fa4-1cd9-46c3-9995-995c618f03ad";
      fsType = "btrfs";
      options = ["subvol=root"];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/8d869fa4-1cd9-46c3-9995-995c618f03ad";
      fsType = "btrfs";
      options = ["subvol=home"];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/8d869fa4-1cd9-46c3-9995-995c618f03ad";
      fsType = "btrfs";
      options = ["subvol=nix"];
    };

    fileSystems."/persist" = {
      device = "/dev/disk/by-uuid/8d869fa4-1cd9-46c3-9995-995c618f03ad";
      fsType = "btrfs";
      options = ["subvol=persist"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/A5A4-B0B4";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/f514ab58-4219-4d88-aba0-5d441f977743";}
    ];
  };
}
