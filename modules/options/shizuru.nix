{
  imports = [
    ../common
    ../desktop
    ../share/package-options.nix
  ];
  drivers.intel.enable = true;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = true;
    intelBusID = "PCI:0:2:0";
    nvidiaBusID = "PCI:1:0:0";
  };
  vm.guest-services.enable = false;
  local.hardware-clock.enable = true;
  modules.terminal.foot.enable = true;
  system.packages.enable = true;
  system.kernel.enable = true;
  system.bootloader-systemd.enable = true;
  system.bootloader-grub.enable = false;
  system.sddm-stray.enable = false;
  system.plymouth.enable = true;
  system.audio.enable = true;
  system.displayManager.enable = true;
  system.greetd.enable = false;
  system.powermanagement.enable = true;
  system.scheduler.enable = true;
  mine.hypridle.enable = false;
  mine.cliphist.enable = true;
  mine.wlogout.enable = true;
  mine.wleave.enable = true;
  system.zfs.enable = true;
  system.zram.enable = true;
  cfg.wayland.wl-clip-persist.enable = false;
}
