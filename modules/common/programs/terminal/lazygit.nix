{
  pkgs,
  lib,
  ...
}: {
  hj = {
    packages = [pkgs.lazygit];
  };
}
