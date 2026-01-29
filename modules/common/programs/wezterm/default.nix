{
  pkgs,
  inputs,
  ...
}: let
  wezterm = inputs.wezterm.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  hj = {
    packages = [pkgs.wezterm];
  };
}
