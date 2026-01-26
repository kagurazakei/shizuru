{...}: {
  hj.rum.desktops.hyprland = {
    settings = {
      "$scratchpadsize" = "size 60% 65%";
      "$scratchpad" = "class:^(scratchpad.foo)$";
    };

    extraConfig = ''
      windowrule {
        name = windowrule-1
        float = on
        center = on
      }

      windowrule {
        name = windowrule-2
        tag = +browser
        opacity = 1.0 1.0
        match:class = ^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$
      }

      windowrule {
        name = windowrule-3
        tag = +browser
        workspace = 2
        match:class = ^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$
      }

      windowrule {
        name = windowrule-4
        tag = +browser
        opacity = 0.94 0.86
        match:class = ^(chrome-.+-Default)$
      }

      windowrule {
        name = windowrule-5
        tag = +browser
        match:class = ^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$
      }

      windowrule {
        name = windowrule-6
        tag = +browser
        match:class = ^(Brave-browser(-beta|-dev|-unstable)?)$
      }

      windowrule {
        name = windowrule-7
        tag = +browser
        match:class = ^([Tt]horium-browser|[Cc]achy-browser)$
      }

      windowrule {
        name = windowrule-8
        tag = +browser
        opacity = 0.9 0.7
        match:class = ^(zen-alpha)$
      }

      windowrule {
        name = windowrule-9
        tag = +terminal
        match:class = ^(Alacritty|kitty|kitty-dropterm)$
      }

      windowrule {
        name = windowrule-10
        tag = +email
        match:class = ^([Tt]hunderbird|org.gnome.Evolution)$
      }

      windowrule {
        name = windowrule-11
        tag = +email
        match:class = ^(eu.betterbird.Betterbird)$
      }

      windowrule {
        name = windowrule-12
        tag = +projects
        match:class = ^(codium|codium-url-handler|VSCodium)$
      }

      windowrule {
        name = windowrule-13
        tag = +projects
        opacity = 0.9 0.8
        match:class = ^(VSCode|code-url-handler)$
      }

      windowrule {
        name = windowrule-14
        tag = +projects
        opacity = 0.9 0.8
        match:class = ^(jetbrains-.+)$
      }

      windowrule {
        name = windowrule-15
        tag = +screenshare
        opacity = 0.9 0.7
        match:class = ^(com.obsproject.Studio)$
      }

      windowrule {
        name = windowrule-16
        tag = +im
        match:class = ^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$
      }

      windowrule {
        name = windowrule-17
        tag = +im
        float = on
        workspace = 7
        size = (monitor_w*0.6) (monitor_h*0.7)
        opacity = 0.9 0.7
        match:class = ^([Ff]erdium)$
      }

      windowrule {
        name = windowrule-18
        tag = +im
        float = on
        size = (monitor_w*0.6) (monitor_h*0.7)
        opacity = 0.9 0.7
        match:class = ^([Ww]hatsapp-for-linux)$
      }

      windowrule {
        name = windowrule-19
        tag = +im
        opacity = 0.9 0.8
        match:class = ^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$
      }

      windowrule {
        name = windowrule-20
        tag = +im
        match:class = ^(teams-for-linux)$
      }

      windowrule {
        name = windowrule-21
        tag = +games
        match:class = ^(gamescope)$
      }

      windowrule {
        name = windowrule-22
        tag = +games
        match:class = ^(steam_app_\d+)$
      }

      windowrule {
        name = windowrule-23
        tag = +gamestore
        workspace = 5
        match:class = ^([Ss]team)$
      }

      windowrule {
        name = windowrule-24
        tag = +gamestore
        match:title = ^([Ll]utris)$
      }

      windowrule {
        name = windowrule-25
        tag = +gamestore
        match:class = ^(com.heroicgameslauncher.hgl)$
      }

      windowrule {
        name = windowrule-26
        tag = +file-manager
        match:class = ^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$
      }

      windowrule {
        name = windowrule-27
        tag = +file-manager
        opacity = 0.8 0.7
        match:class = ^(app.drey.Warp)$
      }

      windowrule {
        name = windowrule-28
        tag = +wallpaper
        match:title = ^([Ww]aytrogen)$
      }

      windowrule {
        name = windowrule-29
        tag = +wallpaper
        match:class = ^([Ww]aytrogen)$
      }

      windowrule {
        name = windowrule-30
        tag = +multimedia
        workspace = 9 silent
        opacity = 0.9 0.7
        match:class = ^([Aa]udacious)$
      }

      windowrule {
        name = windowrule-31
        tag = +settings
        center = on
        float = on
        size = (monitor_w*0.6) (monitor_h*0.7)
        match:title = ^(ROG Control)$
      }

      windowrule {
        name = windowrule-32
        tag = +settings
        float = on
        match:class = ^(wihotspot(-gui)?)$
      }

      windowrule {
        name = windowrule-33
        tag = +settings
        float = on
        match:class = ^([Bb]aobab|org.gnome.[Bb]aobab)$
      }

      windowrule {
        name = windowrule-34
        tag = +settings
        match:class = ^(gnome-disks|wihotspot(-gui)?)$
      }

      windowrule {
        name = windowrule-35
        tag = +settings
        float = on
        size = (monitor_w*0.6) (monitor_h*0.7)
        opacity = 0.9 0.8
        match:title = (Kvantum Manager)
      }

      windowrule {
        name = windowrule-36
        tag = +settings
        float = on
        size = (monitor_w*0.6) (monitor_h*0.7)
        opacity = 0.9 0.8
        match:class = ^(file-roller|org.gnome.FileRoller)$
      }

      windowrule {
        name = windowrule-37
        tag = +settings
        float = on
        match:class = ^(nm-applet|nm-connection-editor|blueman-manager)$
      }

      windowrule {
        name = windowrule-38
        tag = +settings
        float = on
        match:class = ^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$
      }

      windowrule {
        name = windowrule-39
        tag = +settings
        opacity = 0.9 0.8
        match:class = ^(nwg-look|qt5ct|qt6ct|[Yy]ad)$
      }

      windowrule {
        name = windowrule-40
        tag = +settings
        float = on
        match:class = (xdg-desktop-portal-gtk)
      }

      windowrule {
        name = windowrule-41
        tag = +settings
        float = on
        match:class = ^(org.kde.polkit-kde-authentication-agent-1)$
      }

      windowrule {
        name = windowrule-42
        tag = +settings
        float = on
        opacity = 0.9 0.6
        match:class = ^([Rr]ofi)$
      }

      windowrule {
        name = windowrule-43
        tag = +viewer
        float = on
        size = (monitor_w*0.7) (monitor_h*0.7)
        opacity = 0.82 0.75
        match:class = ^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$
      }

      windowrule {
        name = windowrule-44
        tag = +viewer
        float = on
        match:class = ^(evince)$
      }

      windowrule {
        name = windowrule-45
        tag = +viewer
        float = on
        match:class = ^(eog|org.gnome.Loupe)$
      }

      windowrule {
        name = windowrule-46
        center = on
        match:class = ^class:^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$
      }

      windowrule {
        name = windowrule-47
        center = on
        match:class = ^class:^([Ww]hatsapp-for-linux)$
      }

      windowrule {
        name = windowrule-48
        center = on
        match:class = ^class:^([Ff]erdium)$
      }

      windowrule {
        name = windowrule-49
        center = on
        float = on
        match:class = ([Tt]hunar)
        match:title = (File Operation Progress)
      }

      windowrule {
        name = windowrule-50
        center = on
        float = on
        match:class = ([Tt]hunar)
        match:title = (Confirm to replace files)
      }

      windowrule {
        name = windowrule-51
        center = on
        match:title = ^(Keybindings)$
      }

      windowrule {
        name = windowrule-52
        center = on
        match:class = ^(system-monitoring-center)$
      }

      windowrule {
        name = windowrule-53
        center = on
        float = on
        size = 1200 900
        match:title = Spotify
      }

      windowrule {
        name = windowrule-54
        center = on
        float = on
        size = 1000 800
        match:title = ^(nixy)
      }

      windowrule {
        name = windowrule-55
        center = on
        float = on
        size = 1000 800
        match:class = ^(hiddify)$
      }

      windowrule {
        name = windowrule-56
        center = on
        match:class = ^(org.wezfurlong.wezterm|com.mitchellh.ghostty)$
      }

      windowrule {
        name = windowrule-57
        center = on
        float = on
        size = 1100 1350
        idle_inhibit = floating
        match:class = ^(org.pwmt.zathura)$
      }

      windowrule {
        name = windowrule-58
        center = on
        float = on
        size = 600 1200
        match:class = ^(.protonvpn-app-wrapped)$
      }

      windowrule {
        name = windowrule-59
        center = on
        float = on
        size = 1400 1000
        match:title = ^(Flatseal)$
      }

      windowrule {
        name = windowrule-60
        center = on
        match:class = ^(ghostty-dropterm)$
      }

      windowrule {
        name = windowrule-61
        float = on
        size = 1800 1000
        match:class = ([Tt]hunar)$
      }

      windowrule {
        name = windowrule-62
        float = on
        center = on
        size = 1800 1000
        match:title = mpv
      }

      windowrule {
        name = windowrule-63
        float = on
        center = on
        size = 1800 1000
        match:title = Qv2ray
      }

      windowrule {
        name = windowrule-64
        float = on
        center = on
        match:class = ^([Ss]potify|[Ww]aypaper|Dolphin|[Ww]aypaper-engine|org.Waytrogen.Waytrogen)$
      }

      windowrule {
        name = windowrule-65
        size = 1800 1000
        match:class = ^([Ss]potify|[Ww]aypaper|Dolphin|[Ww]aypape-engine|org.Waytrogen.Waytrogen)$
      }

      windowrule {
        name = windowrule-66
        float = on
        center = on
        size = 1200 1000
        match:class = ^(pamac-manager)$
      }

      windowrule {
        name = windowrule-67
        float = on
        center = on
        size = 1800 1000
        match:title = ^(hyprpanel-settings)$
      }

      windowrule {
        name = windowrule-68
        float = on
        center = on
        size = 1800 1000
        match:title = Dolphin
      }

      windowrule {
        name = windowrule-69
        float = on
        center = on
        size = 1000 1000
        match:class = ^(nvidia-settings)$
      }

      windowrule {
        name = windowrule-70
        float = on
        match:class = ([Zz]oom|onedriver|onedriver-launcher)$
      }

      windowrule {
        name = windowrule-71
        float = on
        match:class = (org.kde.dolphin)
      }

      windowrule {
        name = windowrule-72
        float = on
        match:class = (org.gnome.Calculator)
        match:title = (Calculator)
      }

      windowrule {
        name = windowrule-73
        float = on
        match:class = (codium|codium-url-handler|VSCodium|code-oss)
        match:title = (Add Folder to Workspace)
      }

      windowrule {
        name = windowrule-74
        float = on
        match:class = (electron)
        match:title = (Add Folder to Workspace)
      }

      windowrule {
        name = windowrule-75
        float = on
        match:class = ^(nwg-look|qt5ct|qt6ct)$
      }

      windowrule {
        name = windowrule-76
        float = on
        match:class = ^(mpv|com.github.rafostar.Clapper)$
      }

      windowrule {
        name = windowrule-77
        float = on
        match:class = ^([Yy]ad)$
      }

      windowrule {
        name = windowrule-78
        float = on
        match:class = ^([Ss]team)$
        match:title = ^((?![Ss]team).*|[Ss]team [Ss]ettings)$
      }

      windowrule {
        name = windowrule-79
        float = on
        match:class = ^([Qq]alculate-gtk)$
      }

      windowrule {
        name = windowrule-80
        float = on
        size = (monitor_w*0.25) (monitor_h*0.25)
        pin = on
        keep_aspect_ratio = on
        move = ((monitor_w*0.72)) ((monitor_h*0.07))
        opacity = 0.95 0.75
        match:title = ^(Picture-in-Picture)$
      }

      windowrule {
        name = windowrule-81
        workspace = 1
        match:class = ^([Tt]hunderbird)$
      }

      windowrule {
        name = windowrule-82
        workspace = 2
        opacity = 0.9 0.8
        match:class = ^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable)?)$
      }

      windowrule {
        name = windowrule-83
        workspace = 2 silent
        match:class = ^([Tt]horium-browser|zen-alpha)$
      }

      windowrule {
        name = windowrule-84
        workspace = 4 silent
        match:class = ^(com.obsproject.Studio|[Ss]potify)$
      }

      windowrule {
        name = windowrule-85
        workspace = 5
        match:class = ^([Ll]utris|[Mm]pv)$
      }

      windowrule {
        name = windowrule-86
        workspace = 7
        match:class = ^([Ww]hatsapp-for-linux|[Vv]scodium)$
      }

      windowrule {
        name = windowrule-87
        workspace = 5 silent
        match:title = VSCodium
      }

      windowrule {
        name = windowrule-88
        workspace = 6 silent
        match:class = ^(virt-manager)$
      }

      windowrule {
        name = windowrule-89
        size = (monitor_w*0.7) (monitor_h*0.7)
        opacity = 0.9 0.8
        match:class = ^(xdg-desktop-portal-gtk)$
      }

      windowrule {
        name = windowrule-90
        size = (monitor_w*0.6) (monitor_h*0.7)
        match:class = ^(qt6ct)$
      }

      windowrule {
        name = windowrule-91
        size = (monitor_w*0.7) (monitor_h*0.7)
        match:class = ^(evince|wihotspot(-gui)?)$
      }

      windowrule {
        name = windowrule-92
        idle_inhibit = fullscreen
        match:class = ^(org.telegram.desktop)$
      }

      windowrule {
        name = windowrule-93
        idle_inhibit = fullscreen
        match:class = ^(info.febvre.Komikku)$
      }

      windowrule {
        name = windowrule-94
        idle_inhibit = focus
        match:class = ^(firefox|chromium|librewolf|info.febvre.Komikku)$
      }

      windowrule {
        name = windowrule-95
        idle_inhibit = focus
        match:class = ^(org.pwmt.zathura|info.febvre.Komikku)$
      }

      windowrule {
        name = windowrule-96
        idle_inhibit = full
        match:class = ^(mpv|vlc|celluloid|info.febvre.Komikku)$
      }

      windowrule {
        name = windowrule-97
        idle_inhibit = fullscreen
        match:class = ^(*)$
      }

      windowrule {
        name = windowrule-98
        idle_inhibit = fullscreen
        match:title = ^(*)$
      }

      windowrule {
        name = windowrule-99
        idle_inhibit = fullscreen
        match:fullscreen = 1
      }

      windowrule {
        name = windowrule-100
        suppress_event = maximize
        match:class = .*
      }

      windowrule {
        name = windowrule-101
        opacity = 1.0 1.0
        match:class = ^([Ss]potify)$
      }

      windowrule {
        name = windowrule-102
        opacity = 1.0 1.0
        match:class = ^(Brave-browser(-beta|-dev)?)$
      }

      windowrule {
        name = windowrule-103
        opacity = 0.9 0.6
        match:class = ^([Tt]horium-browser)$
      }

      windowrule {
        name = windowrule-104
        opacity = 0.9 0.8
        match:class = ^(google-chrome(-beta|-dev|-unstable)?)$
      }

      windowrule {
        name = windowrule-105
        opacity = 0.9 0.8
        match:class = ^([Tt]hunar|org.gnome.Nautilus)$
      }

      windowrule {
        name = windowrule-106
        opacity = 0.8 0.6
        match:class = ^(pcmanfm-qt)$
      }

      windowrule {
        name = windowrule-107
        opacity = 0.8 0.7
        match:class = ^(gedit|org.gnome.TextEditor|mousepad)$
      }

      windowrule {
        name = windowrule-108
        opacity = 0.9 0.8
        match:class = ^(deluge)$
      }

      windowrule {
        name = windowrule-109
        opacity = 0.9 0.8
        match:class = ^(firefox|org.wezfurlong.wezterm|foot|com.mitchellh.ghostty|Alacritty|kitty|kitty-dropterm|equibop)$
      }

      windowrule {
        name = windowrule-110
        opacity = 0.7 0.9
        match:class = ^(VSCodium|codium-url-handler|code-oss)$
      }

      windowrule {
        name = windowrule-111
        opacity = 1.0 0.98
        match:class = ^([Dd]iscord|[Vv]esktop)$
      }

      windowrule {
        name = windowrule-112
        opacity = 0.9 0.8
        match:class = ^(im.riot.Riot)$
      }

      windowrule {
        name = windowrule-113
        opacity = 0.94 0.86
        match:class = ^(gnome-disks|evince|wihotspot(-gui)?|org.gnome.baobab)$
      }

      windowrule {
        name = windowrule-114
        opacity = 0.9 0.8
        match:class = ^(seahorse)$
      }


    '';
  };
}
