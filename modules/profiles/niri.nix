{self, ...}: {
  azalea.profiles.niri = {
    imports = [
      self.azalea.modules.niri
      self.azalea.modules.noctalia
      self.azalea.modules.xdg
      self.azalea.modules.xdg-portal-fix
      self.azalea.modules.polkit
      self.azalea.services.nirinit
    ];
  };
}
