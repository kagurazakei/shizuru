{ inputs, pkgs, ...}:
{ hj.packages = [ inputs.yazi.packages.${pkgs.stdenv.hostPlatform.system}.default];}
