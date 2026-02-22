{
  pkgs,
  sources,
  ...
}: let
  lib = pkgs.lib;
  isDebug = false;

  # Call tg_owt subpackage
  tg_owt = pkgs.callPackage (sources.ayugram-desktop + "/lib/tg_owt.nix") {};

  # Unwrapped derivation
  ayugramUnwrapped = pkgs.stdenv.mkDerivation rec {
    pname = "ayugram-desktop-unwrapped";
    version = "nightly";

    src = sources.ayugram-desktop + "/source";

    dontUnpack = true; # ⚡ Tell Nix src is already unpacked

    nativeBuildInputs = [
      pkgs.cmake
      pkgs.ninja
      pkgs.pkg-config
      pkgs.python3
      pkgs.clang
      pkgs.gobject-introspection
    ];

    buildInputs = [
      pkgs.kdePackages.qtbase
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtwayland
      pkgs.kdePackages.kcoreaddons

      pkgs.lz4
      pkgs.xxHash
      pkgs.ffmpeg_6
      pkgs.openalSoft
      pkgs.minizip
      pkgs.range-v3
      pkgs.tl-expected
      pkgs.rnnoise
      pkgs.microsoft-gsl
      pkgs.boost
      pkgs.ada
      pkgs.protobuf
      pkgs.hunspell

      (pkgs.tdlib.override {tde2eOnly = true;})
      tg_owt
    ];

    cmakeFlags = [
      (lib.cmakeBool "DESKTOP_APP_DISABLE_AUTOUPDATE" true)
      (lib.cmakeFeature "TDESKTOP_API_ID" "611335")
      (lib.cmakeFeature "TDESKTOP_API_HASH" "d524b414d21f4d37f08684c1df41ac9c")
      (lib.cmakeFeature "CMAKE_BUILD_TYPE" (
        if isDebug
        then "Debug"
        else "Release"
      ))
    ];

    dontWrapQtApps = true;

    installPhase = ''
      cmake --install .
    '';

    meta = with lib; {
      description = "AyuGram Desktop Telegram client with customization and Ghost mode.";
      homepage = "https://ayugram.one";
      license = licenses.gpl3Only;
      maintainers = with maintainers; [
        kaeeraa
        s0me1newithhand7s
      ];
      platforms = builtins.filter (x: x != platforms.darwin) platforms.all;
      mainProgram = "AyuGram";
    };
  };
in
  # ⚡ Wrapper derivation
  pkgs.stdenv.mkDerivation rec {
    pname = "ayugram-desktop";
    version = ayugramUnwrapped.version;

    src = ayugramUnwrapped; # Use the unwrapped derivation output

    dontUnpack = true; # ⚡ same fix for wrapper

    nativeBuildInputs = [pkgs.kdePackages.wrapQtAppsHook];

    buildInputs = [
      pkgs.kdePackages.qtbase
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtwayland
      pkgs.kdePackages.kcoreaddons
    ];

    qtWrapperArgs = [
      "--prefix"
      "LD_LIBRARY_PATH"
      ":"
      (lib.makeLibraryPath [pkgs.webkitgtk_4_1])
    ];

    dontWrapGApps = true;

    installPhase = ''
      runHook preInstall
      cp -r "$src" "$out"
      runHook postInstall
    '';

    postFixup = ''
      substituteInPlace $out/share/dbus-1/services/* \
        --replace-fail "$src" "$out"
    '';

    meta = ayugramUnwrapped.meta;
  }
