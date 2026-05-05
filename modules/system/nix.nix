{
  azalea.modules.nix = {
    pkgs,
    config,
    lib,
    sources,
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
    documentation.nixos.enable = false;
    documentation.info.enable = false;
    documentation.man.enable = false;
    chaotic.nyx.cache.enable = lib.mkForce false;
    nixpkgs.flake.source = lib.mkForce sources.unstable;
    nix = {
      package = pkgs.nixVersions.git;
      nixPath = ["nixpkgs=/etc/nixos/nixpkgs"];
      registry.nixpkgs.to = {
        type = "path";
        path = sources.unstable;
      };
      channel.enable = false;
      settings = {
        warn-dirty = false;
        accept-flake-config = true; # allow using substituters from flake.nix
        trusted-substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
        experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];
        commit-lockfile-summary = "chore(deps): update flake";
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
          "https://heitor.cachix.org"
          "https://niri-nix.cachix.org"
        ];
        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
          "loneros.cachix.org-1:dVCECfW25sOY3PBHGBUwmQYrhRRK2+p37fVtycnedDU="
          "heitor.cachix.org-1:IZ1ydLh73kFtdv+KfcsR4WGPkn+/I926nTGhk9O9AxI="
          "niri-nix.cachix.org-1:SvFtqpDcf7Sm1SMJdby1/+Y+6f3Yt3/3PMcSTKPJNJ0="
        ];
      };
      gc = {
        persistent = true;
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      extraOptions = ''
        allow-import-from-derivation = false
        !include ${config.age.secrets.secret2.path}
        connect-timeout = 60
        require-sigs = false
      '';
    };
    system.activationScripts.diff = ''
      if [[ -e /run/current-system ]]; then
        ${script}/bin/activate "$systemConfig"
      fi
    '';
  };
}
