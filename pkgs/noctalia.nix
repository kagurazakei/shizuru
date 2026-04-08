{
  pkgs,
  lib,
  sources,
  bluetoothSupport ? true,
  brightnessctlSupport ? true,
  cavaSupport ? true,
  cliphistSupport ? true,
  ddcutilSupport ? true,
  wlsunsetSupport ? true,
  wl-clipboardSupport ? true,
  imagemagickSupport ? true,
  calendarSupport ? false,
  gpuScreenRecorderSupport ? false,
}: let
  stdenvNoCC = pkgs.stdenvNoCC;
  qt6 = pkgs.qt6;
  quickshell = pkgs.noctalia-qs.overrideAttrs (_: {
    src = sources.noctalia-qs;
  });
  # runtime dependencies
  runtimeDeps =
    [
      pkgs.wget
      (pkgs.python3.withPackages (pp: lib.optional calendarSupport pp.pygobject3))
    ]
    ++ lib.optional bluetoothSupport pkgs.bluez
    ++ lib.optional brightnessctlSupport pkgs.brightnessctl
    ++ lib.optional cavaSupport pkgs.cava
    ++ lib.optional cliphistSupport pkgs.cliphist
    ++ lib.optional ddcutilSupport pkgs.ddcutil
    ++ lib.optional wlsunsetSupport pkgs.wlsunset
    ++ lib.optional wl-clipboardSupport pkgs.wl-clipboard
    ++ lib.optional imagemagickSupport pkgs.imagemagick
    ++ lib.optional gpuScreenRecorderSupport pkgs.gpu-screen-recorder;

  # GI Typelib path for optional calendar support
  giTypelibPath = lib.makeSearchPath "lib/girepository-1.0" [
    pkgs.evolution-data-server
    pkgs.libical
    pkgs.glib.out
    pkgs.libsoup_3
    pkgs.json-glib
    pkgs.gobject-introspection
  ];
in
  stdenvNoCC.mkDerivation rec {
    pname = "noctalia-shell";
    version = "nightly";
    src = sources.noctalia-shell;

    nativeBuildInputs = [
      qt6.wrapQtAppsHook
    ];

    buildInputs = [
      qt6.qtbase
      qt6.qtmultimedia
      pkgs.python3
      quickshell
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/noctalia-shell $out/bin
      ln -s ${quickshell}/bin/qs $out/bin/noctalia-shell

      cp -R \
        Assets Commons CREDITS.md Helpers Modules Services Shaders Scripts Widgets shell.qml \
        $out/share/noctalia-shell

      rm -R $out/share/noctalia-shell/Assets/Screenshots || true

      runHook postInstall
    '';

    # Wrap with Qt environment and setup QML paths
    preFixup = ''
      qtWrapperArgs+=(
        --prefix PATH : ${lib.makeBinPath runtimeDeps}
        --prefix XDG_DATA_DIRS : $out/share/noctalia-shell:${pkgs.wayland-scanner}/share
        --add-flags "-p $out/share/noctalia-shell"
        ${lib.optionalString calendarSupport "--prefix GI_TYPELIB_PATH : ${giTypelibPath}"}
      )

      # Set QML import path for shell modules
      export QML2_IMPORT_PATH="$out/share/noctalia-shell"
      export QT_PLUGIN_PATH="${qt6.qtbase}/lib/qt6/plugins:$QT_PLUGIN_PATH"
      export XDG_DATA_DIRS="$out/share/noctalia-shell:$XDG_DATA_DIRS"
    '';

    passthru = {
      # optional update script
      updateScript = pkgs.nix-update-script {};
    };

    meta = with lib; {
      description = "Sleek and minimal desktop shell thoughtfully crafted for Wayland, built with Quickshell";
      homepage = "https://github.com/noctalia-dev/noctalia-shell";
      license = licenses.mit;
      mainProgram = "noctalia-shell";
      maintainers = [pkgs.lib.maintainers.spacedentist];
      platforms = quickshell.meta.platforms;
      changelog = "https://github.com/noctalia-dev/noctalia-shell/releases";
    };
  }
