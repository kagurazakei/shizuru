{
  inputs,
  pkgs,
  ...
}:
let
  yazi = inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.yazi;
in
{
  hj.packages = [ yazi ];
}
