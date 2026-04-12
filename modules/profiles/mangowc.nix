{self, ...}: {
  azalea.profiles.mangowc = {
    imports = [
      self.azalea.modules.mangowc
    ];
  };
}
