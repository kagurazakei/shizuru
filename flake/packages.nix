{self, ...}: let
  sources = import ../npins;
  system = "x86_64-linux";
  nixpkgs' = import sources.unstable {
    inherit system;
    config.allowUnfree = true;
  };
  inherit (nixpkgs'.lib) filesystem callPackageWith;
in {
  packages = self.lib.eachSystem (
    {
      zpkgs,
      system,
      ...
    }: let
      # Use npins-based pkgs
      pkgs' = import sources.unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
      filesystem.packagesFromDirectoryRecursive {
        inherit (pkgs') newScope;
        callPackage = callPackageWith (pkgs' // zpkgs);
        directory = self.paths.pkgs;
      }
  );
}
