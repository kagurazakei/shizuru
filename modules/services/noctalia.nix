{
  azalea.modules.noctalia = {
    pkgs,
    lib,
    self,
    ...
  }: let
    system = pkgs.stdenv.hostPlatform.system;
    zpkgs = self.packages.${system};
  in {
    environment.systemPackages = [
      zpkgs.noctalia
    ];
    hj = {
      systemd.services = {
        noctalia-shell = {
          description = "noctalia shell for niri";
          after = ["graphical-session.target"];
          partOf = ["graphical-session.target"];
          serviceConfig = {
            ExecStart = "${lib.getExe zpkgs.noctalia} -d";
            Restart = "on-failure";
          };
        };
      };
    };
  };
}
