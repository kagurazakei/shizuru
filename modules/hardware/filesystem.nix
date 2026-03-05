{
  azalea.modules.filesystems = {
    lib,
    config,
    ...
  }: let
    hostname = config.networking.hostName;

    hanaFs = {
      fileSystems."/" = {
        device = "/dev/disk/by-uuid/47a75818-824d-4cb1-bbeb-663415918292";
        fsType = "btrfs";
        options = ["subvol=root"];
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/b66cdd35-b90d-423a-8d08-6333d0f901c8";
        fsType = "btrfs";
      };

      fileSystems."/nix" = {
        device = "/dev/disk/by-uuid/47a75818-824d-4cb1-bbeb-663415918292";
        fsType = "btrfs";
        options = ["subvol=nix"];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/4577-6170";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };

      swapDevices = [
        {device = "/dev/disk/by-uuid/2cfd7bef-e433-4d31-ac35-ec00b181d660";}
      ];
    };

    kaguraFs = {
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
  in {
    config = lib.mkMerge [
      (lib.mkIf (hostname == "hana") hanaFs)
      (lib.mkIf (hostname == "kagura") kaguraFs)
    ];
  };
}
