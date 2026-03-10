{nixpkgs, ...}: {
  azalea.modules.nix = {
    pkgs,
    config,
    lib,
    ...
  }: let
    script = pkgs.writers.writeNuBin "activate" ''
      def main [systemConfig: string] {
        let diff_closure = ${pkgs.nix}/bin/nix store diff-closures /run/current-system $systemConfig;
        if $diff_closure != "" {
          let table = $diff_closure
          | lines
          | where $it =~ KiB
          | where $it =~ →
          | parse -r '^(?<Package>\S+): (?<Old_Version>[^,]+)(?:.*) → (?<New_Version>[^,]+)(?:.*, )(?<DiffBin>.*)$'
          | insert Diff {
            get DiffBin
            | ansi strip
            | str trim -l -c '+'
            | into filesize
          }
          | reject DiffBin
          | sort-by -r Diff;

          print $table;
          $table | math sum
        }
      }
    '';
  in {
    nixpkgs.config.allowUnfree = true;
    chaotic.nyx.cache.enable = lib.mkForce false;
    nix = {
      package = pkgs.nixVersions.git;
      registry.nixpkgs.flake = nixpkgs;
      channel.enable = false;
      settings = {
        warn-dirty = false;
        allow-import-from-derivation = false;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        auto-optimise-store = true;
        trusted-users = [
          "root"
          "@wheel"
        ];
        substituters = ["https://hyprland.cachix.org"];
        extra-substituters = [
          "https://nix-community.cachix.org"
          "https://cache.garnix.io"
          "https://loneros.cachix.org"
        ];
        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          "loneros.cachix.org-1:dVCECfW25sOY3PBHGBUwmQYrhRRK2+p37fVtycnedDU="
        ];
      };
      gc = {
        persistent = true;
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      extraOptions = ''
        !include ${config.age.secrets.secret2.path}
      '';
    };
    system.activationScripts.diff = ''
      if [[ -e /run/current-system ]]; then
        ${script}/bin/activate "$systemConfig"
      fi
    '';
  };
}
