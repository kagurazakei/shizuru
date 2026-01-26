{...}: {
  hj.rum.desktops.hyprland = {
    settings = {
      "$mainMod" = "SUPER";
      "$scriptsDir" = "$HOME/.config/hypr/scripts";
      "$UserConfigs" = "$HOME/.config/hypr/UserConfigs";
      "$Touchpad_Device" = "elan962c:00-04f3:30d0-touchpad";
      "$TOUCHPAD_ENABLED" = true;
      "$dock" = "$dockbottom-round";
      "$dockbottom" = "nwg-dock-hyprland -i 48 -mb 10 -ml 12 -mt 10 -nolauncher -x -l -a bottom -d -s ~/.config/nwg-dock-hyprland/style.css -r";
      "$dockbottom-attached" = "nwg-dock-hyprland -i 48 -ml 12 -mr 12 -nolauncher -x -l bottom -s style-dark-catp.css";
      "$dockbottom-round" = "nwg-dock-hyprland -r -i 48 -ml 12 -mr 12 -mb 12 -nolauncher -x -l bottom -s style-dark-red-bottom-round.css";
      "$dockleft" = "nwg-dock-hyprland --nolauncher -i 58 -ml 12 -mb 15 -mt 5 -x -p \"left\" -a \"center\" -s style-dark-red-left.css -c \"rofi -show drun\"";

      monitor = [
        "eDP-1, highres, auto, 1"
      ];

      device = {
        name = "$Touchpad_Device";
        enabled = "$TOUCHPAD_ENABLED";
      };

      misc = {
        vrr = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        key_press_enables_dpms = true;
        mouse_move_enables_dpms = true;
        font_family = "JetBrainsMono Nerd Font";
        vfr = false;
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
        focus_on_activate = false;
        initial_workspace_tracking = 0;
        middle_click_paste = false;
        animate_manual_resizes = false;
      };

      general = {
        gaps_in = 3;
        gaps_out = [2 5 4 5];
        border_size = 2;
        resize_on_border = true;
        hover_icon_on_border = true;
        layout = "scrolling";
      };

      decoration = [
        {
          rounding = 12;
          rounding_power = 2.0;
          blur = {
            enabled = true;
            size = 6;
            passes = 3;
            noise = 0.0;
            contrast = 1.0;
            new_optimizations = true;
            ignore_opacity = true;
            xray = false;
            vibrancy = 0.2696;
            vibrancy_darkness = 0.3;
          };
        }
        {
          dim_special = 0.1;
          blur.special = true;
          shadow = {
            enabled = false;
            range = 4;
            render_power = 2;
            color = "rgba(000000FF)";
            sharp = true;
          };
        }
      ];

      animations = {
        enabled = true;
      };

      input = {
        touchpad = {
          tap-to-click = true;
          disable_while_typing = true;
          natural_scroll = false;
        };
        kb_layout = "us,mm";
        kb_options = "caps:swapescape, grp:alt_shift_toggle, fkeys:basic_13-24";
        repeat_rate = 50;
        repeat_delay = 300;
        sensitivity = 0.2;
        numlock_by_default = true;
        left_handed = false;
        follow_mouse = true;
        float_switch_override_focus = false;
        touchdevice.enabled = true;
        tablet = {
          transform = 0;
          left_handed = 0;
        };
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
        special_scale_factor = 1;
      };

      master = {
        new_status = "master";
        new_on_top = 1;
        mfact = 0.5;
      };

      gestures = {
        workspace_swipe_distance = 500;
        workspace_swipe_invert = false;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = true;
        workspace_swipe_forever = true;
        workspace_swipe_use_r = true;
      };

      opengl = {
        nvidia_anti_flicker = true;
      };

      xwayland = {
        enabled = true;
        force_zero_scaling = true;
        use_nearest_neighbor = true;
      };

      cursor = {
        no_hardware_cursors = true;
        enable_hyprcursor = true;
        sync_gsettings_theme = true;
        warp_on_change_workspace = true;
        no_warps = true;
      };

      binds = {
        workspace_back_and_forth = true;
        allow_workspace_cycles = false;
        pass_mouse_when_bound = false;
        drag_threshold = 10;
      };
    };

    extraConfig = ''
      exec-once = $HOME/.config/hypr/initial-boot.sh
      source = $HOME/.config/hypr/UserConfigs/windowRules.conf
      source = $HOME/.config/hypr/themes/mocha.conf
      source = $HOME/.config/hypr/animations/LimeFrenzy.conf

      bind = $mainMod, mouse:272, movewindow
      bind = ALT, mouse:272, togglefloating
    '';
  };
}
