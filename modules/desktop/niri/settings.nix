{
  lib,
  pkgs,
  inputs,
  ...
}: let
  niri-package = pkgs.nur.repos.lonerOrz.niri-Naxdy;
  inherit (lib.meta) getExe;
  inherit (lib.filesystem) listFilesRecursive;
  niri-blur = niri-package.override {
    withDbus = true;
    withSystemd = true;
    withScreencastSupport = true;
    withDinit = false;
    withNative = true;
    withLto = true;
  };
in {
  nixpkgs.overlays = [
    inputs.nur.overlays.default
  ];
  imports = [
    inputs.noctalia-shell.nixosModules.default
    inputs.dms.nixosModules.dank-material-shell
    inputs.nix-monitor.nixosModules.default
  ];
  services.noctalia-shell = {
    enable = false;
  };

  programs.dankMaterialShell = {
    enable = true;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dankMaterialShell changes
    };
    # Core features
    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableDynamicTheming = true; # Wallpaper-based theming (matugen)
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)

    plugins = {
      DockerManager = {
        src = pkgs.fetchFromGitHub {
          owner = "LuckShiba";
          repo = "DmsDockerManager";
          rev = "v1.2.0";
          sha256 = "sha256-VoJCaygWnKpv0s0pqTOmzZnPM922qPDMHk4EPcgVnaU=";
        };
      };
    };
  };

  programs.nix-monitor = {
    enable = true;

    # Required: customize for your setup
    rebuildCommand = [
      "bash"
      "-c"
      "sudo nixos-rebuild switch --flake .#hana 2>&1"
    ];
    gcCommand = [
      "bash"
      "-c"
      "sudo nix-collect-garbage -d 2>&1"
    ];
    generationsCommand = [
      "bash"
      "-c"
      "nix-env --list-generations --profile /nix/var/nix/profiles/system | wc -l"
    ];
    updateInterval = 600;
  };
  hj.rum.desktops.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.system}.niri;
    config = lib.concatMapStringsSep "\n" builtins.readFile [./configs/ribbons.kdl ./configs/inputs.kdl ./configs/rule.kdl ./configs/settings.kdl];
    #configFile = pkgs.concatText "config.kdl" (listFilesRecursive ./configs);
    spawn-at-startup = [
      ["wl-paste" "--type" "image" "--watch" "cliphist" "store"]
      ["${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"]
      ["wl-paste" "--type" "text" "--watch" "cliphist" "store"]
      ["dbus-update-activation-environment" "--systemd" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"]
      ["systemctl" "--user" "import-environment" "WAYLAND_DISPLAY" "XDG_CURRENT_DESKTOP"]
      ["dbus-update-activation-environment" "--all"]
      ["${pkgs.xwayland-satellite}/bin/xwayland-satellite"]
      ["${pkgs.xdg-desktop-portal-gnome}/libexec/xdg-desktop-portal-gnome"]
    ];
    extraVariables = {
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,x11";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORMTHEME = "qt6ct";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      OZONE_PLATFORM = "wayland";
      JAVA_AWT_WM_NONEREPARENTING = "1";
      ELECTRON_ENABLE_HARDWARE_ACCELERATION = "1";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "niri";
      DISPLAY = ":0";
    };
  };
}
