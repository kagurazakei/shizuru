{
  lib,
  pkgs,
  ...
}: let
  inherit (lib.meta) getExe;
in {
  hj.rum.desktops.niri.binds = {
    XF86AudioRaiseVolume = {
      parameters.allow-when-locked = true;
      spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"];
    };
    XF86AudioLowerVolume = {
      parameters.allow-when-locked = true;
      spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
    };
    XF86AudioMute = {
      parameters.allow-when-locked = true;
      spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
    };
    XF86MonBrightnessUp = {
      parameters.allow-when-locked = true;
      spawn = ["/home/antonio/.local/bin/brightness" "--inc"];
    };
    XF86MonBrightnessDown = {
      parameters.allow-when-locked = true;
      spawn = ["/home/antonio/.local/bin/brightness" "--dec"];
    };
    Print.action = "screenshot-screen";
    "Shift+Print".action = "screenshot";
    "Ctrl+Print".action = "screenshot-window";
    "Mod+Shift+Alt+S".action = "screenshot-window";
    "Mod+Shift+S".action = "screenshot";
    "Mod+D".spawn = ["noctalia-shell" "ipc" "call" "launcher" "toggle"];
    "Mod+N".spawn = ["noctalia-shell" "ipc" "call" "bar" "toggle"];
    "Mod+Return".spawn = ["kitty"];
    "Mod+E".spawn = ["walker" "-m" "emojis"];
    "Alt+grave".spawn = ["niri-switch"];
    "Mod+Shift+X".spawn = ["ani-cli" "--rofi"];
    "Mod+Shift+Return".spawn = ["wezterm"];
    "Ctrl+Alt+L".spawn = ["noctalia-shell" "ipc" "call" "lockScreen" "lock"];
    "Mod+T".spawn = ["dolphin"];
    "Mod+O".spawn = ["walker"];
    "Mod+I".spawn = ["fuzzel-clip"];
    "Mod+R".spawn = ["noctalia-shell" "ipc" "call" "wallpaper" "toggle"];
    "Mod+X".spawn = ["noctalia-shell" "ipc" "call" "sessionMenu" "toggle"];
    "Mod+Backspace".spawn = ["wlogout"];
    "Mod+B".spawn = ["eww-bar"];
    "Mod+Q".action = "close-window";
    "Mod+S".action = "switch-preset-column-width";
    "Mod+F".action = "maximize-column";
    "Mod+M".spawn = ["walker" "-m" "niri"];
    "Mod+Shift+Space".action = "fullscreen-window";
    "Mod+Shift+F".action = "expand-column-to-available-width";
    "Mod+Space".action = "toggle-window-floating";
    "Mod+V".spawn = ["noctalia-shell" "ipc" "call" "launcher" "clipboard"];
    "Mod+Comma".action = "consume-window-into-column";
    "Mod+Period".action = "expel-window-from-column";
    "Mod+C".action = "center-window";
    "Mod+grave".action = "switch-focus-between-floating-and-tiling";
    "Mod+Tab".action = "toggle-overview";
    "Mod+1".action = "focus-workspace 1";
    "Mod+2".action = "focus-workspace 2";
    "Mod+3".action = "focus-workspace 3";
    "Mod+4".action = "focus-workspace 4";
    "Mod+5".action = "focus-workspace 5";
    "Mod+6".action = "focus-workspace 6";
    "Mod+7".action = "focus-workspace 7";
    "Mod+8".action = "focus-workspace 8";
    "Mod+9".action = "focus-workspace 9";
    "Mod+Minus".action = "set-column-width \"-10%\"";
    "Mod+Equal".action = "set-column-width \"+10%\"";
    "Mod+Shift+Minus".action = "set-window-height \"-10%\"";
    "Mod+Shift+Equal".action = "set-window-height \"+10%\"";
    "Mod+H".action = "focus-column-left";
    "Mod+L".action = "focus-column-right";
    "Mod+J".action = "focus-window-or-workspace-down";
    "Mod+K".action = "focus-window-or-workspace-up";
    "Mod+Left".action = "focus-column-left";
    "Mod+Right".action = "focus-column-right";
    "Mod+Down".action = "focus-workspace-down";
    "Mod+Up".action = "focus-workspace-up";
    "Mod+Shift+H".action = "move-column-left";
    "Mod+Shift+L".action = "move-column-right";
    "Mod+Shift+K".action = "move-column-to-workspace-up";
    "Mod+Shift+J".action = "move-column-to-workspace-down";
    "Mod+Shift+Ctrl+J".action = "move-column-to-monitor-down";
    "Mod+Shift+Ctrl+K".action = "move-column-to-monitor-up";
  };
}
