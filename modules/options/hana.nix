{
  imports = [
    ../common/system
    ../common/desktop
    ../common/drivers
    ../common/programs
    ../desktop/default.nix
    ../share/package-options.nix
  ];
  drivers.intel.enable = false;
  drivers.amdgpu.enable = true;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = false;
    intelBusID = "PCI:0:2:0";
    nvidiaBusID = "PCI:1:0:0";
  };
  vm.guest-services.enable = false;
  local.hardware-clock.enable = true;
  system.packages.enable = true;
  system.kernel.enable = true;
  system.bootloader-systemd.enable = true;
  system.bootloader-grub.enable = false;
  system.sddm-stray.enable = false;
  system.plymouth.enable = true;
  system.audio.enable = true;
  system.displayManager.enable = false;
  system.greetd.enable = true;
  system.powermanagement.enable = true;
  system.scheduler.enable = true;
  mine.hypridle.enable = false;
  mine.cliphist.enable = true;
  mine.wlogout.enable = true;
  mine.wleave.enable = true;
  #system.zfs.enable = false;
  system.zram.enable = true;
  cfg.wayland.wl-clip-persist.enable = false;
}
