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

        extra-substituters = [
          "https://nix-community.cachix.org"
          "https://cache.garnix.io"
          "https://niri.cachix.org"
          "https://loneros.cachix.org"
          "https://kagurazakei.cachix.org"
        ];
        extra-trusted-public-keys = [
          "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
          "loneros.cachix.org-1:dVCECfW25sOY3PBHGBUwmQYrhRRK2+p37fVtycnedDU="
          "kagurazakei.cachix.org-1:L150C/szoC/r6LOupCWQRU5IqdWIBl926O1HpiBVEkw="
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
