{ niri, ... }:
{
  azalea.modules.niri =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      environment.systemPackages = [
        pkgs.hyprsunset
        pkgs.xwayland-satellite
        pkgs.jq
        pkgs.yazi
        pkgs.nwg-look
      ];
      services.displayManager.defaultSession = "niri-uwsm";
      systemd.user.services.hypridle.path = lib.mkForce [ config.programs.hyprland.package ];
      systemd.user.services.xwayland-satellite.wantedBy = [ "graphical-session.target" ];
      programs.niri = {
        enable = true;
        package = niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      };
      programs.uwsm = {
        enable = true;
        waylandCompositors = {
          niri = {
            prettyName = "Niri The Goat";
            comment = "Niri Compositor managed by UWSM";
            binPath = "/run/current-system/sw/bin/niri-session";
          };
        };
      };
      hj = {
        packages = with pkgs; [
          xdg-desktop-portal-gnome
          xdg-desktop-portal-wlr
          polkit_gnome
        ];
      };
      # I could write a hypersunrise service to conflict but fuck it better to just
      # make a keybind to stop the service lol And I am less likely to forget to
      # turn the darn thing off if its right on my face
      systemd.user.timers.hyprsunset = {
        description = "Start hyprsunset after sunset";
        enable = true;
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "*-*-* 17:30:00";
        };
      };
      systemd.user.services.hyprsunset = {
        enable = true;
        description = "starts hyprsunset for blue light filtering";
        after = [ "graphical.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.hyprsunset}/bin/hyprsunset -t 3000";
        };
      };
    };
}
