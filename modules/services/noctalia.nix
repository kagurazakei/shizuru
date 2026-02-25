{
  azalea.modules.noctalia = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      noctalia-shell
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
