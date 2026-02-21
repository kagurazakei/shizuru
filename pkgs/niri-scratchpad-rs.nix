{
  pkgs,
  sources,
}: let
  rustOverlay = import sources.rust-overlay;

  pkgsWithRust = import pkgs.path {
    inherit (pkgs) system;
    overlays = [rustOverlay];
  };

  rustPlatform = pkgsWithRust.makeRustPlatform {
    cargo = pkgsWithRust.rust-bin.beta.latest.default;
    rustc = pkgsWithRust.rust-bin.beta.latest.default;
  };
in
  rustPlatform.buildRustPackage {
    pname = "niri-scratchpad-rs";
    version = "1.1.0";

    src = sources.niri-scratchpad-rs;

    cargoLock = {
      lockFile = "${sources.niri-scratchpad-rs}/Cargo.lock";
    };

    nativeBuildInputs = with pkgsWithRust; [
      pkg-config
    ];

    buildInputs = with pkgsWithRust; [
      openssl
    ];
  }
