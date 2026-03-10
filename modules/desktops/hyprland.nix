{
  azalea.modules.hyprland = {
    pkgs,
    lib,
    config,
    self,
    inputs,
    ...
  }: {
    imports = [
      self.azalea.modules.ambxst
      self.azalea.modules.xdg
      # inputs.hyprland.nixosModules.default
    ];
    hj.xdg.config.files = {
      "hypr/plugins.conf".text = ''
        exec-once = hyprctl plugin load ${
          inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
        }/lib/libhyprscrolling.so
      '';
    };
    environment.systemPackages = with pkgs; [
      hyprsunset
      inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
    ];
    systemd.user.services.hypridle.path = lib.mkForce [config.programs.hyprland.package];
    programs.hyprland = {
      enable = true;
      # package = hyprPkgs.hyprland;
      withUWSM = true;
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
    # programs.hyprland = {
    #   plugins = [
    #     inputs.hyprland-plugins.packages.${pkgs.stdenv.hostPlatform.system}.hyprscrolling
    #   ];
    # };

    # I could write a hypersunris service to conflict but fuck it better to just
    # make a keybind to stop the service lol And I am less likely to forget to
    # turn the darn thing off if its right on my face
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
