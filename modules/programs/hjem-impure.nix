{
  azalea.modules.hjem-impure = {
    pkgs,
    sources,
    ...
  }: {
    hjem.extraModules = [(sources.hjem-impure + "/nix/module.nix")];
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
