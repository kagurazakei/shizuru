{nix-gaming, ...}: {
  azalea.modules.steam = {pkgs, ...}: {
    imports = [
      nix-gaming.nixosModules.wine
      nix-gaming.nixosModules.pipewireLowLatency
      nix-gaming.nixosModules.platformOptimizations
    ];

    programs.wine = {
      enable = true;
      # package = inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.wine-cachyos;
    };
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      lowLatency = {
        enable = true;
        quantum = 64;
        rate = 48000;
      };
    };

    security.rtkit.enable = true;
    programs = {
      gamemode.enable = true;
      gamescope = {
        enable = true;
        capSysNice = true;
        args = [
          "--rt"
          "--expose-wayland"
        ];
      };
      steam = {
        enable = true;
        platformOptimizations.enable = true;
        package = pkgs.steam.override {
          extraPkgs = pkgs:
            with pkgs; [
              freetype
              SDL2
              dbus
              glib
            ];

          extraLibraries = pkgs:
            with pkgs; [
              alsa-lib
            ];
          extraProfile = ''
            export PROTON_LOG=1
            export STEAM_FRAME_FORCE_CLOSE=1
          '';
          extraEnv = {
            LD_PRELOAD_32 = "";
          };
          privateTmp = true;
        };
        extraCompatPackages = [pkgs.proton-ge-bin];
        gamescopeSession.enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };
      xwayland.enable = true;
      dconf.enable = true;
      seahorse.enable = true;
      fuse.userAllowOther = true;
      mtr.enable = true;
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    environment.systemPackages = with pkgs; [
      heroic
      lutris
      mumble
    ];
  };
}
