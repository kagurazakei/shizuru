{
  pkgs,
  inputs,
  ...
}: {
  hj.rum.desktops.hyprland.settings = {
    exec-once = [
      "uwsm finalize"
      "hyprctl setcursor Kureiji-Ollie-v2 34"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "systemctl --user restart cliphist"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "dbus-update-activation-environment --all"
      "swww-daemon --format xrgb"
      "uwsm-app -- qs -c ii -d"
    ];
  };
}
