{self, ...}: {
  azalea.hosts.hana = {
    pkgs,
    config,
    lib,
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
      # self.azalea.modules.intel
      self.azalea.modules.nvidia
      # self.azalea.modules.greetd-autostart
      self.azalea.modules.silent-sddm
      self.azalea.modules.cups
      self.azalea.modules.openssh
    ];

    # info
    system.stateVersion = "26.05";
    networking.hostName = "hana";
    time.timeZone = "Asia/Yangon";
    nixpkgs.hostPlatform = "x86_64-linux";

    # zaphkiel opts
    zaphkiel = {
      data.wallpaper = self.packages.${pkgs.stdenv.hostPlatform.system}.images.corvus;
      # secrets = {
      #   tailAuth.file = self.paths.secrets + /secret5.age;
      #   caddyEnv.file = self.paths.secrets + /secret10.age;
      # };
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
      # services = {
      #   caddy = {
      #     secretsFile = config.age.secrets.caddyEnv.path;
      #     tsplugin.enable = true;
      #   };
      #   tailscale = {
      #     operator = "rexies";
      #     authFile = config.age.secrets.tailAuth.path;
      #   };
      # };
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
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/07d4c304-5420-4374-aaed-6a53e691cffd";
      fsType = "btrfs";
      options = ["subvol=root"];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/712e07f3-65b5-4ea3-b115-dd96147e00f8";
      fsType = "btrfs";
      neededForBoot = true;
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/07d4c304-5420-4374-aaed-6a53e691cffd";
      fsType = "btrfs";
      options = ["subvol=nix"];
    };

    fileSystems."/persist" = {
      device = "/dev/disk/by-uuid/07d4c304-5420-4374-aaed-6a53e691cffd";
      fsType = "btrfs";
      options = ["subvol=persist"];
      neededForBoot = true;
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/B138-1CC7";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };
    swapDevices = [
      {device = "/dev/disk/by-uuid/35b04156-9b91-48de-a117-ccbf04e13001";}
    ];
  };
}
