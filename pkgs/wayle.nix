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
    cargo = pkgs.cargo;
    rustc = pkgsWithRust.rust-bin.beta.latest.default;
  };
in
  rustPlatform.buildRustPackage {
    pname = "wayle";
    version = "git"; # or set from rev if using npins

    src = sources.wayle;

    cargoLock = {
      lockFile = "${sources.wayle}/Cargo.lock";
    };

    nativeBuildInputs = with pkgsWithRust; [
      pkg-config
    ];

    buildInputs = with pkgsWithRust; [
      wayland
      wayland-protocols
      libxkbcommon
    ];

    # Some Wayland tools need this sometimes
    # Uncomment if build fails
    # RUSTFLAGS = "-C link-arg=-Wl,--no-as-needed";

    meta = with pkgs.lib; {
      description = "Wayland layout/session manager";
      license = licenses.mit; # adjust if upstream differs
      platforms = platforms.linux;
    };
  }
