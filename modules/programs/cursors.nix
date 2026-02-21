{
  azalea.modules.cursors =
    { pkgs, sources, ... }:
    {
      environment.systemPackages = [
        (pkgs.callPackage "${sources.waifu-cursors}/default.nix" { }).default
      ];
    };
}
