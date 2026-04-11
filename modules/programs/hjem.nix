{
  azalea.modules.hjem = {
    pkgs,
    lib,
    sources,
    ...
  }: let
    utils = import ../../utils;
    hjemOut = import sources.hjem {};
    hjemFlake = (utils.flakeToNix {src = sources.hjem;}).defaultNix;
  in {
    imports = [hjemOut.nixosModules.default];
    hjem.linker = lib.mkForce hjemFlake.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
  };
}
