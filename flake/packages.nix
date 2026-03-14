{
  self,
  nixpkgs,
  ...
}: let
  inherit (nixpkgs.lib) filesystem callPackageWith;
in {
  packages = self.lib.eachSystem (
    {
      pkgs,
      zpkgs,
      ...
    }:
      filesystem.packagesFromDirectoryRecursive {
        inherit (pkgs) newScope;
        callPackage = callPackageWith (pkgs // zpkgs);
        directory = self.paths.pkgs;
      }
  );
}
