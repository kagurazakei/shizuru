{self, ...}: {
  azalea.hosts.hana = {
    pkgs,
    username,
    ...
  }: let
    pkgx = self.lib.mkPkgx' pkgs;
  in {
    imports = [
      self.azalea.users.zakei
      self.azalea.dots.zakei-cli
      self.azalea.dots.zakei-gui
      self.azalea.dots.zakei-niri
      self.azalea.dots.zakei-hyprland
      self.azalea.dots.zakei-mango
      self.azalea.modules.mangowc
      self.azalea.profiles.default
      self.azalea.profiles.workstation
      self.azalea.profiles.niri
      self.azalea.modules.hyprland
      self.azalea.modules.dolphin
      self.azalea.modules.cursors
      self.azalea.modules.btrfs
      self.azalea.modules.steam
      self.azalea.modules.nvidia
      self.azalea.modules.sysc-greet
      self.azalea.modules.cups
      self.azalea.modules.hana-fs
    ];

    # info
    system.stateVersion = "26.05";
    networking.hostName = "hana";
    time.timeZone = "Asia/Yangon";
    nixpkgs.hostPlatform = "x86_64-linux";
    # zaphkiel opts
    zaphkiel = {
      data.wallpaper = pkgx.images.nix-logo;
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
      # services = {
      #   # caddy = {
      #   #   secretsFile = config.age.secrets.caddyEnv.path;
      #   #   tsplugin.enable = true;
      #   # };
      #   tailscale = {
      #     operator = "antonio";
      #     authFile = config.age.secrets.tailAuth.path;
      #   };
      # };
    };

    # user stuff
    users.users."antonio".packages = [
      pkgs.vscodium
      pkgx.mpv-wrapped
      pkgs.cava
    ];

    # hardware
    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];

    # probably not required, but leaving it in for now
    services.fstrim.enable = true;
  };
}
