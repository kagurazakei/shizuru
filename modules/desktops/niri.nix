{niri, ...}: {
  azalea.modules.niri = {
    pkgs,
    lib,
    config,
    ...
  }: {
    imports = [
      niri.nixosModules.default
    ];
    nixpkgs.overlays = [
      niri.overlays.default
    ];
    environment.systemPackages = [
      pkgs.hyprsunset
      pkgs.xwayland-satellite
      pkgs.jq
      pkgs.yazi
      pkgs.nwg-look
    ];
    services.displayManager.defaultSession = "niri-uwsm";
    systemd.user.services.hypridle.path = lib.mkForce [config.programs.hyprland.package];
    systemd.user.services.xwayland-satellite.wantedBy = ["graphical-session.target"];
    programs.niriBlur = {
      enable = true;
      withUWSM = true;
      useThunar = true;
      withXDG = true;
    };
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
