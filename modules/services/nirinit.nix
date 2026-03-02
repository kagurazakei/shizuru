{
  azalea.services.nirinit = {
    self,
    pkgs,
    ...
  }: let
    system = pkgs.stdenv.hostPlatform.system;
    zpkgs = self.packages.${system};
  in {
    hj = {
      systemd.services = {
        nirinit = {
          description = "nirinit (niri session management)";
          after = ["graphical-session.target"];
          partOf = ["graphical-session.target"];
          serviceConfig = {
            ExecStart = "${zpkgs.nirinit}/bin/nirinit --config /home/antonio/.config/nirinit/config.toml";
            Restart = "always";
          };
        };
      };
    };
  };
}
