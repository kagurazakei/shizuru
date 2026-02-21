{ chaotic, ... }:
{
  azalea.modules.scheduler =
    { ... }:
    {
      imports = [ chaotic.nixosModules.default ];
      chaotic.nyx.overlay.enable = true;
      services.scx = {
        enable = true;
        scheduler = "scx_rusty";
      };
    };
}
