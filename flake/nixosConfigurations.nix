# ╭──────────────────────────────────────────────────────────╮
# │ add inputs for using silent-sddm                                                           │
# ╰──────────────────────────────────────────────────────────╯
{
  self,
  nixpkgs,
  mnw,
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
          mnw
          ;
        username = "antonio";
      };

      modules = [
        self.azalea.hosts.${hostName}
        (
          {...}: {
            nixpkgs.overlays = [
              (_final: prev: {
                zpkgs = self.lib.mkPkgx' prev;
                system = prev.stdenv.hostPlatform.system;
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
