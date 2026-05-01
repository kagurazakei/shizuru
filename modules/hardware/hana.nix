{
  azalea.modules.hana-fs = {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/693ca6be-0b08-4547-bc26-f429cdc7d17e";
      fsType = "btrfs";
      options = ["subvol=root"];
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/bdd04708-03d5-4a45-a009-9dc2920a42dc";
      fsType = "btrfs";
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/693ca6be-0b08-4547-bc26-f429cdc7d17e";
      fsType = "btrfs";
      options = ["subvol=nix"];
    };

    fileSystems."/persist" = {
      device = "/dev/disk/by-uuid/693ca6be-0b08-4547-bc26-f429cdc7d17e";
      fsType = "btrfs";
      options = ["subvol=nix"];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/8662-9096";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/2f93fea5-06d7-4fc8-a2fe-e5605bd8c8eb";}
    ];
  };
}
