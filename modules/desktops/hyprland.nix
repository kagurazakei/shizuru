{
  azalea.modules.hyprland = {
    pkgs,
    lib,
    config,
    self,
    ...
  }: {
    imports = [
      self.azalea.modules.ambxst
      self.azalea.modules.xdg
    ];
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };
    environment.systemPackages = with pkgs; [
      hyprsunset
    ];
    systemd.user.services.hypridle.path = lib.mkForce [config.programs.hyprland.package];
    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      package = pkgs.master.hyprland;
      portalPackage = pkgs.master.xdg-desktop-portal-hyprland;
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
