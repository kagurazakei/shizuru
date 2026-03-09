{
  pkgs,
  lib,
  sources,
}: let
  # pinned quickshell
  quickshellPkg = pkgs.callPackage "${sources.quickshell}/default.nix" {};

  # Ambxst packages from pinned repo
  ttf-phosphor-icons = import "${sources.Ambxst}/nix/packages/phosphor-icons.nix" {inherit pkgs;};

  corePkgs = import "${sources.Ambxst}/nix/packages/core.nix" {inherit pkgs quickshellPkg;};

  toolsPkgs = import "${sources.Ambxst}/nix/packages/tools.nix" {inherit pkgs;};

  mediaPkgs = import "${sources.Ambxst}/nix/packages/media.nix" {inherit pkgs;};

  appsPkgs = import "${sources.Ambxst}/nix/packages/apps.nix" {inherit pkgs;};

  fontsPkgs = import "${sources.Ambxst}/nix/packages/fonts.nix" {
    inherit pkgs ttf-phosphor-icons;
  };

  tesseractPkgs = import "${sources.Ambxst}/nix/packages/tesseract.nix" {inherit pkgs;};

  # Qt / KDE runtime dependencies required for Quickshell
  qtRuntime = with pkgs; [
    qt6.qtdeclarative
    qt6.qt5compat
    qt6.qtsvg
    qt6.qtwayland

    kdePackages.kirigami
    kdePackages.qqc2-desktop-style
  ];

  # Combine environment
  baseEnv = corePkgs ++ toolsPkgs ++ mediaPkgs ++ appsPkgs ++ fontsPkgs ++ tesseractPkgs ++ qtRuntime;

  envAmbxst = pkgs.buildEnv {
    name = "Ambxst-env";
    paths = baseEnv;
  };

  # Fontconfig configuration
  fontconfigConf = pkgs.writeTextDir "etc/fonts/conf.d/99-ambxst-fonts.conf" ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
      <dir>${envAmbxst}/share/fonts</dir>
    </fontconfig>
  '';

  shellSrc = sources.Ambxst;

  launcher = pkgs.writeShellScriptBin "ambxst" ''
    export AMBXST_QS="${quickshellPkg}/bin/qs"

    export PATH="${envAmbxst}/bin:$PATH"

    # Qt / QML runtime
    export QML2_IMPORT_PATH="${envAmbxst}/lib/qt-6/qml:$QML2_IMPORT_PATH"
    export QML_IMPORT_PATH="$QML2_IMPORT_PATH"

    export QML2_IMPORT_PATH="${envAmbxst}/lib/qt-6/qml:${pkgs.kdePackages.kirigami}/lib/qt-6/qml:${pkgs.kdePackages.qqc2-desktop-style}/lib/qt-6/qml:$QML2_IMPORT_PATH"
    export QML_IMPORT_PATH="$QML2_IMPORT_PATH"
    # Fontconfig
    export FONTCONFIG_PATH="${fontconfigConf}/etc/fonts:''${FONTCONFIG_PATH:-}"

    exec ${shellSrc}/cli.sh "$@"
  '';
in
  pkgs.buildEnv {
    name = "Ambxst";

    paths = [
      envAmbxst
      launcher
    ];

    meta = {
      mainProgram = "ambxst";
      description = "Ambxst desktop shell environment";
      platforms = lib.platforms.linux;
    };
  }
