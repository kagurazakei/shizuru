{
  azalea.modules.scheduler = {
    sources,
    flakeCompat,
    ...
  }: let
    chaotic = (flakeCompat.flakeToNix {src = sources.chaotic;}).defaultNix;
  in {
    imports = [chaotic.nixosModules.default];
    chaotic.nyx.overlay.enable = true;
    services.scx = {
      enable = true;
      scheduler = "scx_rusty";
    };
  };
}
