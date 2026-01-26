{
  inputs,
  pkgs,
  ...
}: {
  hj.rum.desktops.hyprland = {
    plugins = [
      #inputs.hyprland-plugins.packages.${pkgs.system}.borders-plus-plus
      #inputs.hyprscroller.packages.${pkgs.system}.hyprscroller
      #inputs.hyprland-plugins.packages.${pkgs.system}.hyprscrolling
      pkgs.master.hyprlandPlugins.hyprscrolling
    ];
  };
}
