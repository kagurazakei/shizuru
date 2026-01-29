{
  pkgs,
  inputs,
  ...
}: {
  hj.packages = [
    inputs.caelestia.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.caelestia-cli.packages.${pkgs.stdenv.hostPlatform.system}.caelestia-cli
    inputs.app2unit.packages.${pkgs.stdenv.hostPlatform.system}.app2unit
  ];
}
