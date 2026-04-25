{
  azalea.modules.nix-index-database = {sources, ...}: {
    imports = [
      (sources.nix-index-database + "/nixos-module.nix")
    ];
    programs.nix-index.enable = true;
  };
}
