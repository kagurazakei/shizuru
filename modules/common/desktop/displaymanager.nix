{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.system.displayManager;
  cursorPkg = inputs.kureiji-ollie-cursor.packages.${pkgs.stdenv.hostPlatform.system}.kureiji-ollie-cursor;
  sddm-theme = inputs.silentSDDM.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
    theme = "new";
  };
in {
  options.system.displayManager = {
    enable = mkEnableOption "Enable Display Manager Services";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      sddm-theme
      sddm-theme.test
      inputs.app2unit.packages.${pkgs.stdenv.hostPlatform.system}.default
      cursorPkg
      inputs.sddm-stray.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.waifu-cursors.packages.${pkgs.stdenv.hostPlatform.system}.Reichi-Shinigami
    ];
    qt.enable = true;
    services.xserver.enable = true;
    services.displayManager.defaultSession = "hyprland-uwsm";
    services.displayManager.sddm = {
      enable = true; # Enable SDDM.
      package = pkgs.kdePackages.sddm;
      extraPackages = sddm-theme.propagatedBuildInputs;
      wayland.enable = true;
      theme = sddm-theme.pname;
      settings = {
        General = {
          GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };
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
