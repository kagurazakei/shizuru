{
  azalea.modules.zram = {
    zramSwap = {
      enable = true;
      priority = 100;
      swapDevices = 1;
      memoryPercent = 80;
      algorithm = "zstd";
    };
  };
}
