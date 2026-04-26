{
  self,
  nixpkgs,
  ...
} @ inputs: let
  sources = import ../npins;
  flakeCompat = import ../utils/flake-compat.nix {};
  with-inputs-libs = import sources.with-inputs sources {};
  with-inputs = with-inputs-libs sources;
  with-inputs-follow =
    with-inputs
    // {
      unstable = with-inputs.unstable;
      master = with-inputs.unstable;
      stable = with-inputs.unstable;
      hjem-impure = with-inputs.hjem;
      hjem = with-inputs.unstable;
      hjem-rum = {
        hjem = with-inputs.hjem;
        nixpkgs = with-inputs.unstable;
      };
      stash = {
        crane = with-inputs.crane;
        nixpkgs = with-inputs.unstable;
      };
    };
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
          flakeCompat
          with-inputs-follow
          ;
        username = "antonio";
      };

      modules = [
        self.azalea.hosts.${hostName}
        {
          nixpkgs.pkgs = import sources.unstable {
            inherit system;
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
                resolved = {
                  inherit
                    (with-inputs-follow)
                    nixpkgs
                    unstable
                    master
                    stable
                    ;
                };
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
