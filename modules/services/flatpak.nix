{...}: {
  azalea.modules.flatpak = {sources, ...}: {
    imports = [
      (sources.nix-flatpak + "/modules/nixos.nix")
    ];
    services = {
      flatpak = {
        enable = true;
        packages = [
          "com.github.tchx84.Flatseal"
          "app.opencomic.OpenComic"
        ];
      };
    };
  };
}
