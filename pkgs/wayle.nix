##
##  check this https://github.com/NixOS/nixpkgs/pull/503416w
##
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
  rustPlatform.buildRustPackage rec {
    pname = "wayle";
    version = "nightly";

    src = sources.wayle;
    cargoHash = "sha256-bOc4BpzxqZBIwPVlJQr1Blo+0+8UyyTUAiGz2Ao8f+s=";
    RUSTC_BOOTSTRAP = true;
    nativeBuildInputs = with pkgsWithRust; [
      glib
      wrapGAppsHook4
      pkg-config
      rustPlatform.bindgenHook
      installShellFiles
    ];

    buildInputs = with pkgsWithRust; [
      libxkbcommon.dev
      gtk4-layer-shell.dev
      udev
      pipewire.dev
      fftw.dev
      libpulseaudio
    ];
    cargoBuildFlags = ["--bin=wayle"];
    preCheck = ''
      export HOME=$(mktemp -d)
    '';
    checkFlags = [
      "--skip=tests::css_loads_into_gtk4"
    ];
    preInstall = ''
      mkdir -p "$out/share/icons"
      cp -r resources/icons "$out/share"
    '';

    postInstall = pkgs.lib.optionalString (pkgs.stdenv.buildPlatform.canExecute pkgs.stdenv.hostPlatform) ''
      installShellCompletion --cmd wayle \
        --bash <($out/bin/wayle completions bash) \
        --fish <($out/bin/wayle completions fish) \
        --zsh <($out/bin/wayle completions zsh)
    '';

    meta = with pkgs.lib; {
      description = "Wayland Elements - A compositor agnostic shell with extensive customization";
      homepage = "https://github.com/wayle-rs/wayle/";
      license = licenses.mit;
      maintainers = [];
      mainProgram = "wayle";
      platforms = platforms.linux;
    };
  }
