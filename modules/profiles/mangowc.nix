{ self, ... }:
{
  azalea.profiles.mangowc = {
    imports = [
      self.azalea.modules.mangowc
      self.azalea.modules.compositor-common
    ];
  };
}
