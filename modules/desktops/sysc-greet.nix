{ sysc-greet, ... }:
{
  azalea.modules.sysc-greet =
    { niri, pkgs, ... }:
    {
      imports = [ sysc-greet.nixosModules.default ];
      services.sysc-greet = {
        enable = true;
        compositor = "niri";
        compositorPackage = niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
        settings = {
          default_session = "uwsm start niri-uwsm.desktop";
        };
      };
    };
}
