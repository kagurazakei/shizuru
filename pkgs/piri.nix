{
  pkgs,
  sources,
  system ? pkgs.stdenv.hostPlatform.system,
}: let
  # Import rust-overlay from sources
  rustOverlay = import sources.rust-overlay;
  # Apply overlay to nixpkgs
  pkgsWithRust = import pkgs.path {
    inherit (pkgs) system;
    overlays = [rustOverlay];
  };

  # Setup rust platform
  rustPlatform = pkgsWithRust.makeRustPlatform {
    cargo = pkgs.cargo;
    rustc = pkgsWithRust.rust-bin.beta.latest.default;
  };
in
  # Build the Rust package
  rustPlatform.buildRustPackage {
    pname = "piri";
    version = "nightly";

    src = sources.piri;

    cargoLock = {
      lockFile = "${sources.piri}/Cargo.lock";
    };

    # Optional: native build dependencies
    nativeBuildInputs = with pkgsWithRust; [
      pkg-config
    ];

    # Optional: runtime dependencies
    buildInputs = with pkgsWithRust; [
      openssl
    ];

    meta = {
      description = "Session restore helper";
      license = pkgs.lib.licenses.mit;
      maintainers = [];
    };
  }
