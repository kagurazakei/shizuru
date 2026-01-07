{
  pkgs,
  config,
  username,
  options,
  lib,
  system,
  inputs,
  ...
}:
with lib; let
  cfg = config.system.greetd;
in {
  imports = [
    inputs.dms.nixosModules.greeter
  ];
  options.system.greetd = {
    enable = mkEnableOption "Enable Greetd Display Manager Services";
  };

  config = mkIf cfg.enable {
    programs.dankMaterialShell.greeter = {
      enable = true;
      compositor.name = "niri"; # Or "hyprland" or "sway"
    };
    services.displayManager.dms-greeter = {
      enable = true;
      compositor.name = "niri";
      package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
    environment.systemPackages = with pkgs; [
      tuigreet
      lyra-cursors
    ];
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          user = "antonio";
          command = "uwsm start niri-uwsm.desktop";
        };
        # default_session = {
        #   user = "greeter";
        #   command = "${pkgs.tuigreet}/bin/tuigreet --user-menu -w 50 --window-padding 7 --container-padding 7 --remember --remember-session --time --theme 'border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red' --cmd uwsm start niri-uwsm.desktop";
        # };
      };
    };

    programs.uwsm.enable = true;
    programs.uwsm.waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor manager by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
      niri = {
        prettyName = "Niri The Goat";
        comment = "Niri compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/niri-session";
      };
    };
  };
}
