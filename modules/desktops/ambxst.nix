{ambxst, ...}: {
  azalea.modules.ambxst = {...}: {
    imports = [
      ambxst.nixosModules.default
    ];
    programs.ambxst = {
      enable = true;
      fonts.enable = true;
    };
  };
}
