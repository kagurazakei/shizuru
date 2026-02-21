{booru-hs, ...}: {
  azalea.modules.booru-hs = {pkgs, ...}: {
    environment.systemPackages = [
      booru-hs.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
