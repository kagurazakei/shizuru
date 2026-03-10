{
  azalea.services.niri-sessions = {
    pkgs,
    self,
    ...
  }: {
    imports = [
      self.zpkgs.nixosModules.nirinit
    ];

    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.nirinit
    ];

    services.nirinit.enable = true;
  };
}
