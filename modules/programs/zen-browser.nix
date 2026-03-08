{
  azalea.modules.zen = {
    sources,
    pkgs,
    ...
  }: let
    fuzzel-clip = pkgs.writeShellScriptBin "fuzzel-clip" ''
      cliphist-fuzzel-img
    '';
  in {
    environment.systemPackages = [
      (pkgs.callPackage "${sources.zen-browser-flake}/default.nix" {}).default
      fuzzel-clip
    ];
  };
}
