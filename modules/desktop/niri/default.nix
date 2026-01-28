{
  inputs,
  pkgs,
  ...
}: let
  wallpaperScript = pkgs.writeScriptBin "niri-wallpaper" (builtins.readFile ./wallpaperAutoChange.sh);
  swww = inputs.swww.packages.${pkgs.stdenv.hostPlatform.system}.swww;
in {
  imports = [
    ./bind.nix
    ./settings.nix
  ];
  hm = {
    imports = [
      inputs.nix-monitor.homeManagerModules.default
    ];

    programs.nix-monitor = {
      enable = true;

      # Required: customize for your setup
      rebuildCommand = [
        "bash"
        "-c"
        "sudo nixos-rebuild switch --flake .#hana 2>&1"
      ];
      generationsCommand = [
        "bash"
        "-c"
        "nixos-rebuild list-generations | wc -l"
      ];

      gcCommand = [
        "bash"
        "-c"
        "sudo nix-collect-garbage -d 2>&1"
      ];
    };

    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.gnome-keyring
    ];
    services.arrpc.enable = true;
    services.swww = {
      enable = true;
      package = swww;
    };
    home = {
      packages = with pkgs; [
        wallpaperScript
        gnome-keyring
        wl-clipboard
        seatd
        jaq
        cage
        qt6.qtwayland
        wl-clip-persist
        cliphist
        xwayland-satellite
        wl-clipboard
        gnome-control-center
        catppuccin-cursors.mochaGreen
      ];
      sessionVariables = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
        XDG_SESSION_TYPE = "wayland";
      };
    };

    systemd.user.services.polkit-gnome = {
      Unit = {
        Description = "GNOME Polkit Agent";
        After = ["graphical-session.target"];
      };
      Service = {
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
