{
  stash,
  self,
  ...
}: {
  packages = self.lib.eachSystem (
    {
      pkgs,
      system,
      zpkgs,
    }: {
      xvim = pkgs.callPackage (self.paths.specials + /xvim) {
        inherit (zpkgs) mnw sources pkgs;
        small = false;
      };
      stash = let
        stp = stash.packages.${system}.default;
      in
        pkgs.symlinkJoin {
          inherit (stp) meta version pname;
          paths = [stp];
          postBuild = ''
            rm $out/bin/wl-copy
            rm $out/bin/wl-paste
          '';
        };
    }
  );
}
