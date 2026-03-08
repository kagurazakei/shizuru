{
  pkgs,
  sources,
}:
pkgs.stdenvNoCC.mkDerivation rec {
  pname = "cat-gtk-themes";
  version = "git";

  src = sources.cat-gtk-themes;

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    # Create install directories
    mkdir -p $out/share/themes
    mkdir -p $out/share/icons

    # -----------------------
    # Install GTK themes
    # -----------------------
    if [ -d themes ]; then
      for dir in themes/*; do
        if [ -d "$dir" ]; then
          cp -r "$dir" $out/share/themes/
        fi
      done
    fi

    # -----------------------
    # Install icon themes
    # -----------------------
    if [ -d icons ]; then
      for f in icons/*; do
        if [ -d "$f" ]; then
          # Folder → copy directly
          cp -r "$f" $out/share/icons/
        elif [ -f "$f" ] && [[ "$f" == *.tar.gz ]]; then
          # tar.gz → extract
          tar -xzf "$f" -C $out/share/icons
        fi
      done
    fi

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Custom Catppuccin GTK and Icon themes (new folder structure)";
    platforms = platforms.linux;
  };

  passthru = {
    themes = "$out/share/themes";
    icons = "$out/share/icons";
  };
}
