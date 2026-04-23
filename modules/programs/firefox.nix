{
  azalea.modules.firefox = {pkgs, ...}: {
    programs.firefox = {
      package = pkgs.master.librewolf;
      enable = true;
    };
  };
}
