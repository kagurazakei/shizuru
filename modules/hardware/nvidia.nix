{
  azalea.modules.nvidia = {
    pkgs,
    config,
    lib,
    ...
  }: {
    options.zaphkiel.graphics.nvidia = {
      hybrid = {
        enable = lib.mkEnableOption "optimus prime";
        igpu = {
          vendor = lib.mkOption {
            type = lib.types.enum [
              "amd"
              "intel"
            ];
            default = "intel";
          };
          port = lib.mkOption {
            default = "";
            description = "Bus Port of igpu";
          };
        };
        dgpu.port = lib.mkOption {
          default = "";
          description = "Bus Port of dgpu";
        };
      };
    };

    config = let
      cfg = config.zaphkiel.graphics.nvidia;
    in {
      nix.settings = {
        extra-substituters = [
          "https://cuda-maintainers.cachix.org"
          "https://aseipp-nix-cache.global.ssl.fastly.net"
        ];
        extra-trusted-public-keys = [
          "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
        ];
      };
      services.xserver.videoDrivers = [
        "nvidia"
      ];

      environment.systemPackages = with pkgs; [
        vulkanPackages_latest.vulkan-loader
        vulkanPackages_latest.vulkan-tools
        libva-utils
        tmux
        bottom
        htop
        egl-wayland
        mesa
        zenith-nvidia
      ];
      boot = {
        initrd.kernelModules = [
          "nvidia"
          "nvidia_modeset"
          "nvidia_uvm"
          "nvidia_drm"
        ];
        kernelModules = [
          "nvidia"
          "nvidia_modeset"
          "nvidia_uvm"
          "nvidia_drm"
        ];

        kernelParams = [
          "nvidia-drm.modeset=1"
          "nvidia-drm.fbdev=1"
        ];
      };

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          libva-vdpau-driver
          libvdpau
          libvdpau-va-gl
          nvidia-vaapi-driver
          vdpauinfo
          libva
          libva-utils
        ];
      };
      hardware.nvidia = {
        modesetting.enable = true;
        dynamicBoost.enable = true;
        powerManagement = {
          enable = true;
          finegrained = cfg.hybrid.enable;
        };

        # Use the NVidia open source kernel module (not to be confused with the
        # independent third-party "nouveau" open source driver).
        open = false;

        nvidiaSettings = true;
        package =
          if config.networking.hostName == "hana"
          then config.boot.kernelPackages.nvidiaPackages.legacy_580
          else
            config.boot.kernelPackages.nvidiaPackages.mkDriver {
              version = "595.58.03";
              sha256_64bit = "sha256-jA1Plnt5MsSrVxQnKu6BAzkrCnAskq+lVRdtNiBYKfk=";
              sha256_aarch64 = "sha256-2vLF5Evl2D6tRQJo0uUyY3tpWqjvJQ0/Rpxan3NOD3c=";
              openSha256 = "sha256-6LvJyT0cMXGS290Dh8hd9rc+nYZqBzDIlItOFk8S4n8=";
              settingsSha256 = "sha256-2vLF5Evl2D6tRQJo0uUyY3tpWqjvJQ0/Rpxan3NOD3c=";
              persistencedSha256 = "sha256-2vLF5Evl2D6tRQJo0uUyY3tpWqjvJQ0/Rpxan3NOD3c=";
            };
        prime = lib.mkIf cfg.hybrid.enable {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };

          amdgpuBusId = lib.mkIf (cfg.hybrid.igpu.vendor == "amd") cfg.hybrid.igpu.port;
          intelBusId = lib.mkIf (cfg.hybrid.igpu.vendor == "intel") cfg.hybrid.igpu.port;
          nvidiaBusId = cfg.hybrid.dgpu.port;
        };
      };
    };
  };
}
