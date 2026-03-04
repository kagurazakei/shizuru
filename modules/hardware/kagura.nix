{
  azalea.modules.kagura-fs = {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/8d869fa4-1cd9-46c3-9995-995c618f03ad";
      fsType = "btrfs";
      options = ["subvol=root"];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/8d869fa4-1cd9-46c3-9995-995c618f03ad";
      fsType = "btrfs";
      options = ["subvol=home"];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/8d869fa4-1cd9-46c3-9995-995c618f03ad";
      fsType = "btrfs";
      options = ["subvol=nix"];
    };

    fileSystems."/persist" = {
      device = "/dev/disk/by-uuid/8d869fa4-1cd9-46c3-9995-995c618f03ad";
      fsType = "btrfs";
      options = ["subvol=persist"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/A5A4-B0B4";
      fsType = "vfat";
      options = [
        "fmask=0022"
        "dmask=0022"
      ];
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/f514ab58-4219-4d88-aba0-5d441f977743";}
    ];
  };
}
