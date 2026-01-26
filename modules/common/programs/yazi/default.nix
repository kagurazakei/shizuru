{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    # initLua = ./configs/init.lua;
  };
}
