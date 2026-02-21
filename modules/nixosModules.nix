{ self, ... }:
{
  nixosModules = {
    kurukuruDM =
      { pkgs, inputs, ... }:
      {
        imports = [ (self.paths.specials + /kurukuruDM.nix) ];
        nixpkgs.overlays = [
          (_: _: {
            inherit (self.packages.${pkgs.stdenv.hostPlatform.system}) kurukurubar;
          })
          inputs.nur.overlays.default
        ];
      };
    default = self.nixosModules.kurukuruDM;
  };
}
