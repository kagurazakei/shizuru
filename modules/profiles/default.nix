{self, ...}: {
  azalea.profiles.default = {
    imports = [
      self.azalea.modules.agenix
      self.azalea.modules.hjem
      self.azalea.modules.hjem-impure
      self.azalea.modules.hjem-matugen
      self.azalea.modules.zaphkiel-data
      self.azalea.modules.locales
      self.azalea.modules.impermanence
      self.azalea.modules.boot
      self.azalea.modules.kernel
      self.azalea.modules.security
      self.azalea.modules.flatpak
      self.azalea.modules.scheduler
      self.azalea.modules.input
      self.azalea.modules.nh
      self.azelea.modules.mpv
      self.azalea.modules.qt
      # programs
      self.azalea.modules.environment
      self.azalea.modules.nix
      self.azalea.modules.fish
      self.azalea.modules.direnv
      # self.azalea.modules.shpool
      # network
      # self.azalea.modules.dnscrypt
      # self.azalea.modules.tailscale
      # self.azalea.modules.openssh
      # hardware
      self.azalea.modules.undetected
    ];
  };
}
