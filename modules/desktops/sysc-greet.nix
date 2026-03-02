{
  azalea.modules.sysc-greet = {
    pkgs,
    sources,
    ...
  }: {
    imports = [(sources.sysc-greet + "/module.nix")];
    environment.systemPackages = [
      (pkgs.callPackage "${sources.sysc-greet}/default.nix" {})
    ];
    environment.pathsToLink = ["/run/current-system/sw/share/wayland-sessions/"];
    services.sysc-greet = {
      enable = true;
      compositor = "niri";
    };
  };
}
