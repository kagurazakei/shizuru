{hjem-impure, ...}: {
  azalea.modules.hjem-impure = {pkgs, ...}: {
    hjem.extraModules = [hjem-impure.hjemModules.default];
    hj = {
      systemd.services = {
        hjem-impure = {
          description = "Hjem Impure Systemd Service";
          after = ["graphical-session.target"];
          partOf = ["graphical-session.target"];
          serviceConfig = {
            ExecStart = "/etc/profiles/per-user/antonio/bin/hjem-impure";
            Restart = "on-failure";
          };
        };
        arrpc = {
          description = "arRPC Systemd Service";
          after = ["graphical-session.target"];
          partOf = ["graphical-session.target"];
          serviceConfig = {
            ExecStart = "${pkgs.arrpc}/bin/arrpc";
            Restart = "on-failure";
          };
        };
      };
    };
  };
}
