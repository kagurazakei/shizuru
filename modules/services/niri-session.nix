{
  azalea.services.niri-sessions = {
    pkgs,
    self,
    ...
  }: let
    zpkgs = self.packages.${pkgs.system};
  in {
    imports = [
      zpkgs.nixosModules.nirinit
    ];

    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.nirinit
    ];

    services.nirinit.enable = true;
  };
}
