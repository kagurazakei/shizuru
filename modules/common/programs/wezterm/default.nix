{
  pkgs,
  inputs,
  ...
}: let
  wezterm = inputs.wezterm.packages.${pkgs.system}.default;
in {
  hj = {
    packages = [pkgs.wezterm];
  };
}
