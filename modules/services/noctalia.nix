{noctalia, ...}: {
  azalea.modules.noctalia = {pkgs, ...}: {
    hj = {
      packages = [noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default];
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
