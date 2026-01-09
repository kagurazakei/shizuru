{
  inputs,
  pkgs,
  config,
  ...
}: {
  programs.mango = {
    enable = true;
  };
}
