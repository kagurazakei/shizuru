{
  lib,
  hyprland,
  hyprlandPlugins,
  sources,
}:
hyprlandPlugins.mkHyprlandPlugin {
  pluginName = "hyprscrolling";
  version = "0.1";
  src = sources.hyprland-plugins + "/hyprscrolling/";

  inherit (hyprland) nativeBuildInputs;

  meta = with lib; {
    homepage = "https://github.com/hyprwm/hyprland-plugins/tree/main/hyprscrolling";
    description = "Hyprland scrolling layout plugin";
    license = licenses.bsd3;
    platforms = platforms.linux;
  };
}
