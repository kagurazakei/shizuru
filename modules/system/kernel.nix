{ nix-cachyos-kernel, ... }:
{
  azalea.modules.kernel =
    { pkgs, ... }:
    {

      nixpkgs.overlays = [
        nix-cachyos-kernel.overlays.pinned
      ];
      console = {
        colors = [
          "1e1e2e"
          "f38ba8"
          "a6e3a1"
          "f9e2af"
          "89b4fa"
          "f5c2e7"
          "94e2d5"
          "bac2de"
          "585b70"
          "f38ba8"
          "a6e3a1"
          "f9e2af"
          "89b4fa"
          "f5c2e7"
          "94e2d5"
          "a6adc8"
        ];
      };

      boot = {
        kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
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
