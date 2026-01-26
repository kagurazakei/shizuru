{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.system.sddm-stray;
  cursorPkg = inputs.kureiji-ollie-cursor.packages.${pkgs.system}.kureiji-ollie-cursor;
in {
  options.system.sddm-stray = {
    enable = mkEnableOption "Enable Display Manager Services";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.lyra-cursors
      inputs.app2unit.packages.${pkgs.system}.default
      cursorPkg
      inputs.sddm-stray.packages.${pkgs.system}.default
      inputs.waifu-cursors.packages.${pkgs.system}.Reichi-Shinigami
    ];
    qt.enable = true;
    services.xserver.enable = true;
    services.displayManager.defaultSession = "hyprland-uwsm";
    services.displayManager.sddm = {
      enable = true; # Enable SDDM.
      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
      ];
      wayland.enable = true;
      theme = "sddm-theme-stray";
      settings = {
        Theme = {
          CursorTheme = "Reichi-Shinigami";
        };
      };
    };
    programs.uwsm.enable = true;
    xdg.terminal-exec = {
      enable = true;
      settings = {
        Hyprland = ["kittty.desktop"];
        Niri = ["kitty.desktop"];
      };
    };
    environment = {
      sessionVariables = {
        UWSM_SILENT_START = 1;
        APP2UNIT_SLICES = "a=app-graphical.slice b=background-graphical.slice s=session-graphical.slice";
        APP2UNIT_TYPE = "scope";
      };
    };
    programs.uwsm.waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor manager by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
      niri = {
        prettyName = "Niri The Goat";
        comment = "Niri";
        binPath = "/run/current-system/sw/bin/niri-session";
      };
    };
  };
}
