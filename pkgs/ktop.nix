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
    cargo = pkgsWithRust.rust-bin.stable.latest.default;
    rustc = pkgsWithRust.rust-bin.stable.latest.default;
  };
in
  rustPlatform.buildRustPackage rec {
    pname = "ktop";
    version = "nightly";

    src = sources.ktop; # path to your ktop-rs source directory
    cargoLock = {
      lockFile = "${sources.ktop}/ktop-rs/Cargo.lock";
    };
    cargoLockUntracked = true;
    nativeBuildInputs = with pkgsWithRust; [
      pkg-config
      cmake # sometimes needed for native dependencies
    ];

    buildInputs = with pkgsWithRust; [
      openssl # example runtime dependency, adjust if needed
    ];

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      cp target/release/ktop $out/bin/ktop
      runHook postInstall
    '';

    meta = with pkgs.lib; {
      description = "Terminal system monitor with GPU support, built with Rust";
      homepage = "https://github.com/brontoguana/ktop";
      license = licenses.mit;
      platforms = platforms.linux;
      maintainers = [];
      mainProgram = "ktop";
    };
  }
