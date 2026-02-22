{
  pkgs,
  sources,
  ...
}: let
  lib = pkgs.lib;
  isDebug = false;

  tg_owt = pkgs.callPackage (sources.ayugram-desktop + "/lib/tg_owt.nix") {};
in
  pkgs.stdenv.mkDerivation (_finalAttrs: {
    pname = "ayugram-desktop-unwrapped";
    version = "6.3.10";

    src = sources.ayugram-desktop;

    nativeBuildInputs = with pkgs; [
      pkg-config
      cmake
      ninja
      python3
      clang
      gobject-introspection
    ];

    buildInputs = with pkgs; [
      kdePackages.qtbase
      kdePackages.qtsvg
      kdePackages.qtwayland
      kdePackages.kcoreaddons

      lz4
      xxHash
      ffmpeg_6
      openalSoft
      minizip
      range-v3
      tl-expected
      rnnoise
      microsoft-gsl
      boost
      ada
      protobuf
      hunspell

      (tdlib.override {tde2eOnly = true;})

      tg_owt
    ];

    dontWrapQtApps = true;

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

    meta = with lib; {
      mainProgram = "AyuGram";

      description = "Desktop Telegram client with good customization and Ghost mode.";

      longDescription = ''
        AyuGram is a fork of Telegram Desktop with a focus on
        customization. It includes features like a customizable
        interface, Ghost mode, and more.
      '';

      homepage = "https://ayugram.one";

      license = licenses.gpl3Only;

      maintainers = with maintainers; [
        kaeeraa
        s0me1newithhand7s
      ];

      platforms = builtins.filter (x: x != platforms.darwin) platforms.all;
    };
  })
