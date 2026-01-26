{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.system.kernel;
in
{
  options.system.kernel = {
    enable = mkEnableOption "Enable custom kernel configuration";
  };

  config = mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_cachyos-lto;
      # kernelPackages = pkgs.linuxPackages_cachyos-lto.extend (
      #   lpself: lpsuper: {
      #     inherit (pkgs.linuxPackages_cachyos-gcc) evdi nvidiaPackages; # 引入 CachyOS-GCC 的 NVIDIA 和 EVDI 驱动模块
      #   }
      # );
      # kernelPackages = let
      #   apply = _: prevModules: {
      #     v4l2loopback =
      #       if strings.hasPrefix "0.15.1" prevModules.v4l2loopback.version
      #       then
      #         prevModules.v4l2loopback.overrideAttrs (_: rec {
      #           version = "0.15.1";
      #           src = pkgs.fetchFromGitHub {
      #             owner = "umlaeute";
      #             repo = "v4l2loopback";
      #             rev = "v${version}";
      #             hash = "sha256-uokj0MB6bw4I8q5dVmSO9XMDvh4T7YODBoCCHvEf4v4=";
      #           };
      #         })
      #       else prevModules.v4l2loopback;
      #   };
      # in
      #   pkgs.linuxPackages_cachyos.extend apply;

      consoleLogLevel = 0;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=0"
        "rd.udev.log_level=0"
        "rd.systemd.show_status=false"
        "udev.log_priority=0"
        "systemd.mask=systemd-vconsole-setup.service"
        "systemd.mask=dev-tpmrm0.device"
        "nowatchdog"
        "modprobe.blacklist=iTCO_wdt"
        "nohibernate"
      ];

      kernelModules = [
        "kvm-intel"
        "drm"
        "i2c-dev"
      ];

      extraModulePackages = [
      ];

      initrd = {
        verbose = false;
        availableKernelModules = [
          "xhci_pci"
          "ahci"
          "nvme"
          "usb_storage"
          "usbhid"
          "sd_mod"
        ];
        kernelModules = [ ]; # GPU kernel modules removed here
      };
    };
  };
}
