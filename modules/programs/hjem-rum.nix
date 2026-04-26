{
  azalea.modules.hjem-rum = {
    sources,
    flakeCompat,
    ...
  }: let
    hjem-rum = (flakeCompat.flakeToNix {src = sources.hjem-rum;}).defaultNix;
  in {
    hjem.extraModules = [hjem-rum.hjemModules.default];
  };
}
