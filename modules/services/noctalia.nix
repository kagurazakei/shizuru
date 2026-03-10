{
  azalea.modules.noctalia = {
    lib,
    pkgs,
    ...
  }: {
    environment.systemPackages = with pkgs; [
      zpkgs.noctalia
    ];
    hj = {
      systemd.services = {
        noctalia-shell = {
          description = "noctalia shell for niri";
          after = ["graphical-session.target"];
          partOf = ["graphical-session.target"];
          serviceConfig = {
            ExecStart = "${lib.getExe pkgs.zpkgs.noctalia} -d";
            Restart = "on-failure";
          };
        };
      };
    };
  };
}
