{
  azalea.desktops.niri = {
    lib,
    config,
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
    services.displayManager.defaultSession = "niri-uwsm";
    systemd.user.services.hypridle.path = lib.mkForce [config.programs.hyprland.package];
    programs.niri = {
      enable = true;
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
