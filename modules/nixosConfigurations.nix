# ╭──────────────────────────────────────────────────────────╮
# │ add inputs for using silent-sddm                                                           │
# ╰──────────────────────────────────────────────────────────╯
{
  self,
  nixpkgs,
  ...
} @ inputs: let
  inherit
    (nixpkgs.lib)
    genAttrs
    nixosSystem
    attrNames
    ;
  sources = import ../npins;
  mkHost = hostName:
    nixosSystem {
      specialArgs = {
        inherit
          inputs
          self
          nixpkgs
          sources
          ;
        username = "antonio";
      };

      modules = [
        self.azalea.hosts.${hostName}
        (
          {pkgs, ...}: {
            nixpkgs.overlays = [
              (_: _: {
                zpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
                system = pkgs.stdenv.hostPlatform.system;
              })
            ];
          }
        )
      ];
    };

  hosts = attrNames self.azalea.hosts;
in {
  nixosConfigurations = genAttrs hosts mkHost;
}
