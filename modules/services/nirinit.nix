{
  azalea.services.nirinit = {pkgs, ...}: {
    hj = {
      systemd.services = {
        nirinit = {
          description = "nirinit (niri session management)";
          after = ["graphical-session.target"];
          partOf = ["graphical-session.target"];
          serviceConfig = {
            ExecStart = "${pkgs.zpkgs.nirinit}/bin/nirinit --config /home/antonio/.config/nirinit/config.toml";
            Restart = "always";
          };
        };
      };
    };
  };
}
