{self, ...}: {
  azalea.hosts.kagura = {
    pkgs,
    config,
    username,
    ...
  }: {
    imports = [
      self.azalea.users.zakei
      self.azalea.dots.zakei-cli
      self.azalea.dots.zakei-gui
      self.azalea.dots.zakei-niri
      self.azalea.dots.zakei-hyprland

      self.azalea.profiles.default
      self.azalea.profiles.workstation
      self.azalea.profiles.niri
      self.azalea.modules.hyprland
      self.azalea.modules.dolphin
      self.azalea.modules.cursors
      self.azalea.modules.btrfs
      self.azalea.modules.intel
      self.azalea.modules.nvidia
      self.azelea.modules.mpv
      self.azalea.modules.sysc-greet
      self.azalea.modules.cups
      self.azalea.modules.kagura-fs
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
      data.wallpaper = pkgs.zpkgs.images.nix-logo;
      graphics.intel.hwAccelDriver = "media-driver";
      graphics.nvidia = {
        hybrid = {
          enable = true;
          igpu.vendor = "intel";
          igpu.port = "PCI:0:2:0";
          dgpu.port = "PCI:1:0:0";
        };
      };
      services = {
        tailscale = {
          operator = "antonio";
          authFile = config.age.secrets.tailAuth.path;
        };
      };
      secrets = {
        antonioPass = {
          file = self.paths.secrets + /kagura-user.age;
          owner = "antonio";
        };
        tailAuth = {
          file = self.paths.secrets + /tailscale.age;
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
    environment.systemPackages = with pkgs; [
      libraw
    ];
    # user stuff
    users.users."antonio".packages = with pkgs; [
      vscodium
      cava
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
    services.fstrim.enable = true;
  };
}
