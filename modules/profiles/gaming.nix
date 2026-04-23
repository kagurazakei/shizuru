{self, ...}: {
  azalea.profiles.gaming = {
    imports = [
      self.azalea.modules.wine
      self.azalea.modules.proton
      self.azalea.modules.sunshine
    ];
  };
}
