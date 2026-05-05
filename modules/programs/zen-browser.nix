{
  azalea.modules.zen = {
    pins,
    pkgs,
    ...
  }: let
    fuzzel-clip = pkgs.writeShellScriptBin "fuzzel-clip" ''
      cliphist-fuzzel-img
    '';
  in {
    environment.systemPackages = [
      # (pkgs.callPackage "${sources.zen-browser-flake}/default.nix" { }).default
      pins.zen-browser-flake.packages.${pkgs.stdenv.hostPlatform.system}.beta
      fuzzel-clip
    ];
  };
}
