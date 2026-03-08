{
  azalea.modules.cursors = {
    pkgs,
    sources,
    ...
  }: {
    environment.systemPackages = [
      (pkgs.callPackage "${sources.waifu-cursors}/default.nix" {}).default
      (pkgs.callPackage "${sources.cat-gtk-themes}/default.nix" {}).default
    ];
  };
}
