{
  azalea.modules.noctalia = {
    pkgs,
    sources,
    lib,
    ...
  }: let
    noctaliaPkg = pkgs.callPackage "${sources.noctalia-shell}/nix/package.nix" {};
  in {
    imports = [
      (sources.noctalia-shell + "/nix/nixos-module.nix")
    ];
    services.noctalia-shell = {
      enable = true;
      package = noctaliaPkg;
    };
    environment.systemPackages = [
      (pkgs.callPackage "${sources.noctalia-shell}/nix/package.nix" {})
    ];
    hj = {
      systemd.services = {
        noctalia-shell = {
          description = "noctalia shell for niri";
          after = ["graphical-session.target"];
          partOf = ["graphical-session.target"];
          serviceConfig = {
            ExecStart = "${lib.getExe noctaliaPkg} -d";
            Restart = "on-failure";
          };
        };
      };
    };
  };
}
