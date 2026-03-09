{...}: {
  azalea.modules.kuruDM-niri = {
    pkgs,
    lib,
    ...
  }: {
    # use mangowc as base for kurukuruDM
    services.greetd.settings.default_session.command = let
      niriConf = pkgs.writeText "config.kdl" ''
        // CHANGED 2025-10-05 - Niri config for greetd greeter session
        // Based on working example from https://github.com/YaLTeR/niri/discussions/1276
        // This config is ONLY used by greetd to show the greeter
        hotkey-overlay {
            skip-at-startup
        }
        cursor {
            xcursor-theme "Kureiji-Ollie-v2"
            xcursor-size 32
        }
        input {
            keyboard {
                xkb {
                    layout "us"
                }
                repeat-delay 400
                repeat-rate 40
            }
            mouse {
         // natural-scroll;

            }
            touchpad {
                tap
         // natural-scroll;
            }
        }
        // Uncomment to hide cursor
        // cursor {
        //     hide-when-typing
        //     hide-after-inactive-ms 1000
        // }
        layer-rule {
            match namespace="^wallpaper$"
            place-within-backdrop true
        }
        layout {
            gaps 0
            center-focused-column "never"
            // No focus ring needed for greeter
            focus-ring {
                off
            }
            // No border needed for greeter
            border {
                off
            }
        }
        // Disable animations for faster startup
        animations {
            off
        }
        window-rule {
            match app-id="kitty"
            opacity 0.9
        }
        // Start gslapper with default wallpaper (forked to background with IPC socket)
        spawn-at-startup "gslapper" "-f" "-I" "/tmp/sysc-greet-wallpaper.sock" "*" "/usr/share/sysc-greet/wallpapers/sysc-greet-default.png"
        spawn-sh-at-startup "XDG_CACHE_HOME=/tmp/greeter-cache HOME=/var/lib/greeter /nix/store/7pjcjlyx7iafpgi606rczchcl980xdn6-kitty-0.45.0/bin/kitty --start-as=fullscreen --config=/etc/greetd/kitty.conf /nix/store/151amk343cm6vi3js6shbpyaj05ag1ay-sysc-greet-1.0.7/bin/sysc-greet; /nix/store/05sa0p40a0digczqkgz96kkvbl1h6bih-niri-25.11/bin/niri msg action quit --skip-confirmation"
        // Empty binds block = no keybindings work (security for greeter)
        binds {

        }

      '';
    in
      lib.mkForce "niri -c ${niriConf}";
  };
}
