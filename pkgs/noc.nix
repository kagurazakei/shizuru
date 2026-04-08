{
  pkgs,
  lib,
  sources,
  bluetoothSupport ? true,
  brightnessctlSupport ? true,
  cliphistSupport ? true,
  ddcutilSupport ? true,
  wlsunsetSupport ? true,
  wl-clipboardSupport ? true,
  wlr-randrSupport ? true,
  imagemagickSupport ? true,
  calendarSupport ? false,
  gpuScreenRecorderSupport ? false,
}: let
  inherit
    (pkgs)
    stdenvNoCC
    qt6
    bluez
    brightnessctl
    cliphist
    ddcutil
    wlsunset
    wl-clipboard
    wlr-randr
    imagemagick
    wget
    gpu-screen-recorder
    python3
    wayland-scanner
    evolution-data-server
    libical
    glib
    libsoup_3
    json-glib
    gobject-introspection
    ;

  # ✅ override nixpkgs package instead of re-calling upstream nix
  noctalia-qs = pkgs.noctalia-qs.overrideAttrs (_: {
    src = sources.noctalia-qs;
    patches = [./noctalia-qs/0001-fix-unneccessary-reloads.patch]; # remove patches
  });

  runtimeDeps =
    [
      wget
      (python3.withPackages (pp: lib.optional calendarSupport pp.pygobject3))
    ]
    ++ lib.optional bluetoothSupport bluez
    ++ lib.optional brightnessctlSupport brightnessctl
    ++ lib.optional cliphistSupport cliphist
    ++ lib.optional ddcutilSupport ddcutil
    ++ lib.optional wlsunsetSupport wlsunset
    ++ lib.optional wl-clipboardSupport wl-clipboard
    ++ lib.optional wlr-randrSupport wlr-randr
    ++ lib.optional imagemagickSupport imagemagick
    ++ lib.optional gpuScreenRecorderSupport gpu-screen-recorder;

  giTypelibPath = lib.makeSearchPath "lib/girepository-1.0" [
    evolution-data-server
    libical
    glib.out
    libsoup_3
    json-glib
    gobject-introspection
  ];
in
  stdenvNoCC.mkDerivation (_finalAttrs: {
    pname = "noctalia-shell";
    version = sources.noctalia-shell.rev or "unstable";
    src = sources.noctalia-shell;

    nativeBuildInputs = [
      qt6.wrapQtAppsHook
    ];

    buildInputs = [
      qt6.qtbase
      qt6.qtmultimedia
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/share/noctalia-shell $out/bin
      ln -s ${noctalia-qs}/bin/qs $out/bin/noctalia-shell

      cp -R \
        Assets Commons CREDITS.md Helpers Modules Services Shaders Scripts Widgets shell.qml \
        $out/share/noctalia-shell

      rm -R $out/share/noctalia-shell/Assets/Screenshots || true

      runHook postInstall
    '';

    preFixup = ''
      qtWrapperArgs+=(
        --prefix PATH : ${lib.makeBinPath runtimeDeps}
        --prefix XDG_DATA_DIRS : ${wayland-scanner}/share
        --add-flags "-p $out/share/noctalia-shell"
        ${lib.optionalString calendarSupport "--prefix GI_TYPELIB_PATH : ${giTypelibPath}"}
      )
    '';

    meta = {
      description = "Sleek and minimal desktop shell thoughtfully crafted for Wayland, built with Quickshell";
      homepage = "https://github.com/noctalia-dev/noctalia-shell";
      license = lib.licenses.mit;
      mainProgram = "noctalia-shell";
      platforms = noctalia-qs.meta.platforms;
    };
  })
