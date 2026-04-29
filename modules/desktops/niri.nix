{
  azalea.desktops.niri = {
    lib,
    config,
    pkgs,
    sources,
    flakeCompat,
    ...
  }: let
    niri = (flakeCompat.flakeToNix {src = sources.niri-nix;}).defaultNix;
  in {
    nix.settings = {
      substituters = [
        "https://niri-nix.cachix.org"
      ];
      trusted-public-keys = [
        "niri-nix.cachix.org-1:SvFtqpDcf7Sm1SMJdby1/+Y+6f3Yt3/3PMcSTKPJNJ0="
      ];
    };
    imports = [
      niri.nixosModules.default
    ];
    nixpkgs.overlays = [niri.overlays.niri-nix];
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
    services.displayManager.defaultSession = "niri-uwsm";
    systemd.user.services.hypridle.path = lib.mkForce [config.programs.hyprland.package];
    systemd.user.services.xwayland-satellite.wantedBy = ["graphical-session.target"];
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
      withUWSM = true;
      useNautilus = false;
      withXDG = true;
    };
    services.dbus.packages = lib.mkForce [
      pkgs.thunar
    ];
    systemd.user.timers.hyprsunset = {
      description = "Start hyprsunset after sunset";
      enable = true;
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "*-*-* 17:30:00";
      };
    };
    systemd.user.services.hyprsunset = {
      enable = true;
      description = "starts hyprsunset for blue light filtering";
      after = ["graphical.target"];
      serviceConfig = {
        ExecStart = "${pkgs.hyprsunset}/bin/hyprsunset -t 3000";
      };
    };
  };
}
