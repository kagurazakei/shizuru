{self, ...}: {
  azalea.profiles.default = {
    imports = [
      self.azalea.modules.agenix
      self.azalea.modules.compositor-common
      self.azalea.modules.hjem
      self.azalea.modules.hjem-impure
      self.azalea.modules.hjem-matugen
      self.azalea.modules.hjem-rum
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
      self.azalea.modules.qt
      self.azalea.modules.starship
      self.azalea.modules.atuin
      self.azalea.dots.fish-config
      # programs
      self.azalea.modules.environment
      self.azalea.modules.nix
      self.azalea.modules.fish
      self.azalea.modules.direnv
      # hardware
      self.azalea.modules.undetected
      self.azalea.modules.zram
    ];
  };
}
