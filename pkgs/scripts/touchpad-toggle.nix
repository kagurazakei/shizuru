{
  pkgs,
  writers,
}: let
  toggleTouchpad = pkgs.writeShellScriptBin "toggle-touchpad" ''
    #!/usr/bin/env bash

    # Declare XDG_RUNTIME_DIR explicitly
    export XDG_RUNTIME_DIR="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"

    DEVICE="elan962c:00-04f3:30d0-touchpad"
    STATE_FILE="''${XDG_RUNTIME_DIR}/touchpad_enabled"

    if [ ! -f "$STATE_FILE" ]; then
        echo "true" > "$STATE_FILE"
    fi

    STATE=$(cat "$STATE_FILE")

    if [ "$STATE" = "true" ]; then
        hyprctl keyword "device[$DEVICE]:enabled" false
        echo "false" > "$STATE_FILE"
        notify-send "Touchpad Disabled" -i input-touchpad
    else
        hyprctl keyword "device[$DEVICE]:enabled" true
        echo "true" > "$STATE_FILE"
        notify-send "Touchpad Enabled" -i input-touchpad
    fi
  '';
in
  writers.writeFishBin "toggle-touchpad" ''
    ${toggleTouchpad}/bin/toggle-touchpad
  ''
