{
  azalea.modules.ambxst = {pins, ...}: {
    imports = [
      pins.ambxst.nixosModules.default
    ];
    programs.ambxst = {
      enable = true;
      fonts.enable = true;
    };
  };
}
