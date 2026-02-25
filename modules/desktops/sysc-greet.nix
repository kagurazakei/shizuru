{sysc-greet, ...}: {
  azalea.modules.sysc-greet = {...}: {
    imports = [sysc-greet.nixosModules.default];
    services.sysc-greet = {
      enable = true;
      compositor = "niri";
      # compositorPackage = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
      settings = {
        default_session = "niri --session";
        user = "antonio";
      };
    };
  };
}
