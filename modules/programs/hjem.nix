{
  azalea.modules.hjem = {
    pkgs,
    lib,
    sources,
    flakeCompat,
    ...
  }: let
    hjemOut = import sources.hjem {};
    hjemFlake = (flakeCompat.flakeToNix {src = sources.hjem;}).defaultNix;
  in {
    imports = [hjemOut.nixosModules.default];
    hjem.linker = lib.mkForce hjemFlake.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
  };
}
