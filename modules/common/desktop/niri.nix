{
  pkgs,
  inputs,
  ...
}: let
  niri-package = pkgs.nur.repos.lonerOrz.niri-Naxdy;
  niri-blur = niri-package.override {
    withDbus = true;
    withSystemd = true;
    withScreencastSupport = true;
    withDinit = false;
    withNative = true;
    withLto = true;
  };
in {
  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
  };
}
