{
  azalea.modules.sysc-greet = {
    pkgs,
    sources,
    ...
  }: {
    imports = [(sources.sysc-greet + "/module.nix")];
    environment.systemPackages = [
      (pkgs.callPackage "${sources.sysc-greet}/default.nix" {})
    ];
    environment.pathsToLink = ["/run/current-system/sw/share/wayland-sessions/"];
    services.sysc-greet = {
      enable = true;
      compositor = "hyprland";
    };
    systemd.services."autovt@" = {
      description = "Virtual Terminal Getty Service";
      documentation = [
        "man:agetty(8)"
        "man:systemd-getty-generator(8)"
      ];
      conflicts = ["console-getty.service"];
      restartIfChanged = false;
      unitConfig.DefaultDependencies = false;
      wantedBy = [
        "multi-user.target"
        "getty.target"
      ];
      serviceConfig = {
        Type = "idle";
        ExecStart = "${pkgs.util-linux}/bin/agetty -o '-p -- \\u' --noclear - $TERM";
        Restart = "always";
        RestartSec = 0;
        UtmpIdentifier = "tty%I";
        TTYPath = "/dev/tty%I";
        TTYReset = "yes";
        TTYVHangup = "yes";
        TTYVTDisallocate = "yes";
        SendSIGKILL = "no";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "journal";
        SyslogIdentifier = "autovt";
      };

      enable = true;
    };
  };
}
