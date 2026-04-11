{
  self,
  nixpkgs,
  ...
} @ inputs: let
  sources = import ../npins;
  inherit
    (nixpkgs.lib)
    genAttrs
    nixosSystem
    attrNames
    ;
  mkHost = hostName: let
    system = self.azalea.hosts.${hostName}.system or "x86_64-linux";
  in
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
        {
          nixpkgs.pkgs = import sources.unstable {
            inherit system;
            inherit (import ../utils) utils;
            config.allowUnfree = true;
          };
        }
        (
          {pkgs, ...}: {
            nixpkgs.overlays = [
              (_final: prev: {
                zpkgs = self.lib.mkPkgx' prev;
                system = prev.stdenv.hostPlatform.system;
                master = import sources.master {
                  inherit (prev.stdenv.hostPlatform) system;
                  config.allowUnfree = true;
                };
                stable = import sources.stable {
                  inherit (prev.stdenv.hostPlatform) system;
                  config.allowUnfree = true;
                };
                swww = pkgs.awww;
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
