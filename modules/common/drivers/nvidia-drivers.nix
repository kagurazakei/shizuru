{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.drivers.nvidia;
  gpl_symbols_linux_615_patch = pkgs.fetchpatch {
    url = "https://github.com/CachyOS/kernel-patches/raw/914aea4298e3744beddad09f3d2773d71839b182/6.15/misc/nvidia/0003-Workaround-nv_vm_flags_-calling-GPL-only-code.patch";
    hash = "sha256-YOTAvONchPPSVDP9eJ9236pAPtxYK5nAePNtm2dlvb4=";
    stripLen = 1;
    extraPrefix = "kernel/";
  };
  nvType = "stable"; # latest beta stable
  nvidiaDrivers = {
    "570.153.02" = {
      version = "575.57.08";
      sha256_64bit = "sha256-KqcB2sGAp7IKbleMzNkB3tjUTlfWBYDwj50o3R//xvI=";
      sha256_aarch64 = "sha256-VJ5z5PdAL2YnXuZltuOirl179XKWt0O4JNcT8gUgO98=";
      openSha256 = "sha256-DOJw73sjhQoy+5R0GHGnUddE6xaXb/z/Ihq3BKBf+lg=";
      settingsSha256 = "sha256-AIeeDXFEo9VEKCgXnY3QvrW5iWZeIVg4LBCeRtMs5Io=";
      persistencedSha256 = "sha256-Len7Va4HYp5r3wMpAhL4VsPu5S0JOshPFywbO7vYnGo=";
      patches = [gpl_symbols_linux_615_patch];
    };

    # done https://github.com/NixOS/nixpkgs/pull/467274
    "580.105.08" = {
      version = "590.44.01";
      sha256_64bit = "sha256-VbkVaKwElaazojfxkHnz/nN/5olk13ezkw/EQjhKPms=";
      sha256_aarch64 = "sha256-gpqz07aFx+lBBOGPMCkbl5X8KBMPwDqsS+knPHpL/5g=";
      openSha256 = "sha256-ft8FEnBotC9Bl+o4vQA1rWFuRe7gviD/j1B8t0MRL/o=";
      settingsSha256 = "sha256-wVf1hku1l5OACiBeIePUMeZTWDQ4ueNvIk6BsW/RmF4=";
      persistencedSha256 = "sha256-nHzD32EN77PG75hH9W8ArjKNY/7KY6kPKSAhxAWcuS4=";
    };
  };

  currentVersion = config.boot.kernelPackages.nvidiaPackages.${nvType}.version;
  nvidiaPackage =
    if builtins.hasAttr currentVersion nvidiaDrivers
    then config.boot.kernelPackages.nvidiaPackages.mkDriver (nvidiaDrivers.${currentVersion})
    else config.boot.kernelPackages.nvidiaPackages.${nvType};
in
  with lib; {
    options.drivers.nvidia.enable = mkEnableOption "Enable NVIDIA Drivers";

    config = mkIf cfg.enable {
      boot = {
        kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];

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
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        nvidiaPersistenced = false;
        open = false;
        nvidiaSettings = true;
        package = nvidiaPackage;
        # package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
  }
