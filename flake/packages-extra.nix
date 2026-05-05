{self, ...}: {
  packages = self.lib.eachSystem (
    {
      pkgs,
      zpkgs,
      system,
    }: let
      sources = import ../npins;
      flakeCompat = import ../utils/flake-compat.nix {};
      input = import ../inputs.nix;
      stash = (flakeCompat.flakeToNix {src = sources.stash;}).defaultNix;
    in {
      xvim = pkgs.callPackage (self.paths.specials + /xvim) {
        inherit (zpkgs) sources;
        mnw = input.mnw.lib;
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
