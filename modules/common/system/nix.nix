{
  pkgs,
  inputs,
  lib,
  ...
}: {
  # nixpkgs.overlays = lib.mkAfter [
  #   (final: prev: {
  #     lix = prev.lix.overrideAttrs (_: {
  #       separateDebugInfo = false;
  #     });
  #   })
  # ];
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  nix = {
    channel.enable = false;
    package = pkgs.nixVersions.git;
    settings = {
      nix-path = [
        "nixpkgs=${inputs.nixpkgs.outPath}"
        "nixpkgs-master=${inputs.nixpkgs-master.outPath}"
        "nixpkgs-stable=${inputs.nixpkgs-stable.outPath}"
      ];
      allowed-users = ["root" "@wheel" "antonio"];
      trusted-users = ["root" "@wheel" "antonio" "@builders"];
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}
