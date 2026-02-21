{ firefox, ... }:
{
  azalea.modules.firefox =
    { pkgs, ... }:
    {
      programs.firefox = {
        package = firefox.packages.${pkgs.stdenv.hostPlatform.system}.firefox-nightly-bin;
        enable = true;
      };
    };
}
