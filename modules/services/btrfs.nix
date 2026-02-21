{ self, ... }:
{
  azalea.modules.btrfs = {
    imports = [ self.azalea.modules.btrfs-snapshots ];
    services.btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [ "/" ];
    };
  };
}
