{noctalia, ...}: {
  azalea.modules.noctalia = {pkgs, ...}: {
    environment.systemPackages = [
      noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    hj = {
      systemd.services = {
        noctalia-shell = {
          description = "noctalia shell for niri";
          after = ["graphical-session.target"];
          partOf = ["graphical-session.target"];
          serviceConfig = {
            ExecStart = "noctalia-shell -d";
            Restart = "on-failure";
          };
        };
      };
    };
  };
}
