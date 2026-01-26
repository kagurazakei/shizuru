{
  pkgs,
  lib,
  ...
}: {
  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
  environment.systemPackages = with pkgs; [
    heroic
    lutris
    mumble
  ];
}
