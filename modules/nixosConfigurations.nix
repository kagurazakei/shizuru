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
      ];
    };

  hosts = attrNames self.azalea.hosts;
in {
  nixosConfigurations = genAttrs hosts mkHost;
}
