{
  pkgs,
  sources,
}: let
  lib = pkgs.lib;

  # Optional rust overlay (if using npins rust-overlay)
  rustOverlay =
    if sources ? rust-overlay
    then import sources.rust-overlay
    else null;

  pkgsWithRust =
    if rustOverlay != null
    then
      import pkgs.path {
        inherit (pkgs) system;
        overlays = [rustOverlay];
      }
    else pkgs;

  # =========================
  # PACKAGE
  # =========================

  nirinit =
    pkgsWithRust.makeRustPlatform
    {
      cargo = pkgsWithRust.rust-bin.stable.latest.default;
      rustc = pkgsWithRust.rust-bin.stable.latest.default;
    }
      .buildRustPackage
    {
      pname = "nirinit";
      version = "nightly";

      src = sources.nirinit; # your source folder

      cargoLock = {
        lockFile = "${sources.nirinit}/Cargo.lock";
      };

      meta = with lib; {
        description = "Session restore tool for Niri";
        mainProgram = "nirinit";
        platforms = platforms.linux;
      };
    };

  nirinitModule = {
    config,
    pkgs,
    ...
  }: let
    inherit
      (lib)
      mkEnableOption
      mkOption
      mkIf
      types
      getExe
      ;

    cfg = config.services.nirinit;
  in {
    options.services.nirinit = {
      enable = mkEnableOption "Nirinit";

      package = mkOption {
        type = types.package;
        default = nirinit;
        description = "nirinit package to use";
      };

      settings = mkOption {
        type = types.submodule {
          freeformType = (pkgs.formats.toml {}).type;

          options = {
            skip = mkOption {
              type = types.submodule {
                options = {
                  apps = mkOption {
                    type = types.listOf types.str;
                    default = [];
                  };
                };
              };
              default = {};
            };

            launch = mkOption {
              type = types.attrsOf types.str;
              default = {};
            };
          };
        };

        default = {};
        description = "Configuration for nirinit";
      };
    };

    config = let
      configFile = (pkgs.formats.toml {}).generate "nirinit-config.toml" cfg.settings;
    in
      mkIf cfg.enable {
        systemd.user.services.nirinit = {
          description = "Nirinit";

          wantedBy = ["graphical-session.target"];
          partOf = ["graphical-session.target"];
          after = ["graphical-session.target"];

          serviceConfig = {
            Type = "simple";
            Restart = "always";
            ExecStart = "${getExe cfg.package} --config ${configFile}";
            PrivateTmp = true;
          };
        };
      };
  };
in {
  # package
  nirinit-module = nirinit;

  # module
  nixosModules = {
    nirinit = nirinitModule;
    default = nirinitModule;
  };
}
