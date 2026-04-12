{
  azalea.modules.hyprland = {
    pkgs,
    lib,
    config,
    self,
    sources,
    flakeCompat,
    ...
  }: let
    hyprnix = (flakeCompat.flakeToNix {src = sources.hyprnix;}).defaultNix;
  in {
    imports = [
      self.azalea.modules.ambxst
      self.azalea.modules.xdg
    ];
    environment.systemPackages = with pkgs; [
      hyprsunset
    ];
    systemd.user.services.hypridle.path = lib.mkForce [config.programs.hyprland.package];
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      package = pkgs.master.hyprland;
      portalPackage = hyprnix.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
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
