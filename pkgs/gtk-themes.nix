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

    mkdir -p $out/share/themes
    mkdir -p $out/share/icons

    for dir in */; do
      # Skip non-theme folders
      if [ "$dir" = "assets/" ]; then
        continue
      fi

      # If contains gtk-3.0 or gtk-4.0 → GTK theme
      if [ -d "$dir/gtk-3.0" ] || [ -d "$dir/gtk-4.0" ]; then
        cp -r "$dir" $out/share/themes/
        continue
      fi

      if [ -d "$dir/gtk-2.0" ] || [ -d "$dir/gtk-3.0" ]; then
        cp -r "$dir" $out/share/themes/
        continue
      fi

      # If contains index.theme but no gtk folder → icon theme
      if [ -f "$dir/index.theme" ]; then
        cp -r "$dir" $out/share/icons/
        continue
      fi
    done

    runHook postInstall
  '';

  meta = with pkgs.lib; {
    description = "Custom Catppuccin GTK and Icon themes";
    platforms = platforms.linux;
  };
}
