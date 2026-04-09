{
  pkgs,
  sources,
}: let
  rustOverlay = import sources.rust-overlay;
  pkgsWithRust = import pkgs.path {
    system = pkgs.stdenv.hostPlatform.system;
    overlays = [rustOverlay];
  };
  rustPlatform = pkgsWithRust.makeRustPlatform {
    cargo = pkgsWithRust.rust-bin.beta.latest.default;
    rustc = pkgsWithRust.rust-bin.beta.latest.default;
  };
in
  rustPlatform.buildRustPackage {
    pname = "nirinit";
    version = "nightly";
    src = sources.nirinit;
    cargoLock = {
      lockFile = "${sources.nirinit}/Cargo.lock";
    };
    nativeBuildInputs = with pkgsWithRust; [
      pkg-config
    ];
    buildInputs = with pkgsWithRust; [
      openssl
    ];

    meta = {
      description = "Session restore helper";
      license = pkgs.lib.licenses.mit;
      maintainers = [];
    };
  }
