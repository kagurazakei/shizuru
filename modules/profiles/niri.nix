{self, ...}: {
  azalea.profiles.niri = {
    imports = [
      self.azalea.modules.niri
      self.azalea.modules.noctalia
      self.azalea.modules.compositor-common
    ];
  };
}
