{
  pkgs,
  lib,
  config ? {},
}: let
  inherit
    (pkgs)
    stdenv
    wrapGAppsHook3
    autoPatchelfHook
    alsa-lib
    curl
    dbus-glib
    gtk3
    libxtst
    pciutils
    pipewire
    adwaita-icon-theme
    writeText
    patchelfUnstable
    fetchurl
    ;
  version = "134.0a1"; # Replace with actual latest nightly version
  src = fetchurl {
    url = "https://archive.mozilla.org/pub/firefox/nightly/latest-mozilla-central/firefox-${version}.en-US.linux-x86_64.tar.bz2";
    hash = ""; # Leave empty, nix will give you the correct hash
  };

  branch = "nightly";

  pname = "firefox-${branch}-bin-unwrapped";

  binaryName = "firefox-${branch}";

  policies =
    {
      DisableAppUpdate = true;
    }
    // (config.firefox.policies or {});

  policiesJson = writeText "firefox-policies.json" (builtins.toJSON {inherit policies;});
in
  stdenv.mkDerivation rec {
    inherit pname version src;

    nativeBuildInputs = [
      wrapGAppsHook3
      autoPatchelfHook
      patchelfUnstable
    ];

    buildInputs = [
      gtk3
      adwaita-icon-theme
      alsa-lib
      dbus-glib
      libxtst
    ];

    runtimeDependencies = [
      curl
      pciutils
    ];

    appendRunpaths = [
      "${pipewire}/lib"
    ];

    # required for Firefox RELR
    patchelfFlags = ["--no-clobber-old-sections"];

    installPhase = ''
      runHook preInstall

      mkdir -p $out/lib/firefox-${version}
      mkdir -p $out/bin

      echo "== Source layout =="
      ls -la
      echo "== Contents of source =="
      ls -la ./*

      # The tarball extracts to a 'firefox' directory
      if [ -d "firefox" ]; then
        echo "Copying from firefox/ subdirectory"
        cp -r firefox/* $out/lib/firefox-${version}/
      else
        echo "ERROR: firefox directory not found"
        echo "Current directory contents:"
        ls -la
        exit 1
      fi

      # Verify the copy worked
      if [ ! -f "$out/lib/firefox-${version}/firefox" ]; then
        echo "ERROR: firefox binary not found after copy"
        echo "Contents of destination:"
        ls -la $out/lib/firefox-${version}/
        exit 1
      fi

      # Rename binaries
      mv $out/lib/firefox-${version}/firefox \
         $out/lib/firefox-${version}/${binaryName}

      if [ -f "$out/lib/firefox-${version}/firefox-bin" ]; then
        mv $out/lib/firefox-${version}/firefox-bin \
           $out/lib/firefox-${version}/${binaryName}-bin
      fi

      # Create symlink in bin
      ln -s $out/lib/firefox-${version}/${binaryName} \
            $out/bin/${binaryName}

      # Add policies
      mkdir -p $out/lib/firefox-${version}/distribution
      ln -s ${policiesJson} \
        $out/lib/firefox-${version}/distribution/policies.json

      runHook postInstall
    '';

    passthru = {
      applicationName = "Firefox";
      inherit binaryName;
      libName = "firefox-${version}";
      ffmpegSupport = true;
      gssSupport = true;
      gtk3 = gtk3;
    };

    meta = {
      description = "Mozilla Firefox Nightly (binary package)";
      homepage = "https://www.mozilla.org/firefox/";
      license = {
        shortName = "unfree";
        fullName = "Firefox Terms of Use";
        url = "https://www.mozilla.org/about/legal/terms/firefox/";
        free = false;
        redistributable = true;
      };
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
      mainProgram = binaryName;
      platforms = lib.platforms.linux;
    };
  }
