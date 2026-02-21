{ self, ... }:
{
  azalea.profiles.workstation = {
    imports = [
      self.azalea.modules.firefox
      self.azalea.modules.zen
      # self.azalea.modules.keyd
      self.azalea.modules.gnupg
      self.azalea.modules.audio
      self.azalea.modules.fonts
      self.azalea.modules.firmware
      self.azalea.modules.bluetooth
      self.azalea.modules.network
      self.azalea.modules.graphics
      # self.azalea.modules.privoxy
    ];
  };
}
