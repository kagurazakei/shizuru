{
  pkgs,
  inputs,
  ...
}: let
  nh = inputs.nh.packages.${pkgs.stdenv.hostPlatform.system}.default;
in {
  programs.nh = {
    package = nh;
    enable = true;
    flake = "/home/antonio/shizuru/";
    clean = {
      enable = true;
      extraArgs = "--keep-since 14d --keep 3";
    };
  };
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    dix
  ];
}
