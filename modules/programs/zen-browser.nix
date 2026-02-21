{
  azalea.modules.zen = {
    sources,
    pkgs,
    ...
  }: {
    environment.systemPackages = [
      (pkgs.callPackage "${sources.zen-browser-flake}/default.nix" {}).default
    ];
  };
}
