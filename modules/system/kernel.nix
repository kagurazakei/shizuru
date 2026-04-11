{
  azalea.modules.kernel = {
    pkgs,
    config,
    sources,
    ...
  }: let
    utils = import ../../utils;
    nix-cachyos-kernel = (utils.flakeToNix {src = sources.nix-cachyos-kernel;}).defaultNix;
  in {
    nixpkgs.overlays = [
      nix-cachyos-kernel.overlays.pinned
    ];
    nix.settings.substituters = ["https://attic.xuyh0120.win/lantian"];
    nix.settings.trusted-public-keys = ["lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="];
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
      kernelPackages =
        if config.networking.hostName == "hana"
        then pkgs.cachyosKernels.linuxPackages-cachyos-rt-bore
        else pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto;
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
        kernelModules = []; # GPU kernel modules removed here
      };
    };
  };
}
