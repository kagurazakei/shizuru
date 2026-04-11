{
  azalea.modules.ambxst = {
    sources,
    flakeCompat,
    ...
  }: let
    ambxst = (flakeCompat.flakeToNix {src = sources.ambxst;}).defaultNix;
  in {
    imports = [
      ambxst.nixosModules.default
    ];
    programs.ambxst = {
      enable = true;
      fonts.enable = true;
    };
  };
}
