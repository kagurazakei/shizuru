{
  azalea.modules.ambxst = {
    pkgs,
    sources,
    self,
    ...
  }: let
    system = pkgs.stdenv.hostPlatform.system;
    zpkgs = self.packages.${system};
  in {
    imports = [
      (sources.Ambxst + "/nix/modules/default.nix")
    ];
    programs.ambxst = {
      enable = true;
      fonts.enable = true;
      package = zpkgs.ambxst;
    };
  };
}
