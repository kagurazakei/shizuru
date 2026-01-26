{
  pkgs,
  inputs,
  system,
  config,
  ...
}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.gh = {
    enable = true;
    package = pkgs.gh;
  };
  programs.imv = {
    enable = true;
  };
  programs.htop = {
    enable = true;
  };
  catppuccin.enable = true;
  catppuccin.btop.enable = false;
  catppuccin.mako.enable = false;
  catppuccin.cava.enable = false;
  catppuccin.kvantum.enable = false;
  services.mako.enable = false;
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    inputs.ags.packages.${pkgs.system}.agsFull
  ];
  home.file = {};

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "wezterm";
    VISUAL = "codium";
    BROWSER = "firefox";
    NIXOS_OZONE_WL = "1";
    _JAVA_AWT_WM_NONEREPARENTING = "1";
    SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
    DISABLE_QT5_COMPAT = "0";
    GDK_BACKEND = "wayland";
    ANKI_WAYLAND = "1";
    DIRENV_LOG_FORMAT = "";
    WLR_DRM_NO_ATOMIC = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_STYLE_OVERRIDE = "kvantum";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    #ANI_CLI_PLAYER = "vlc";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    ZDOTDIR = "$HOME/.config/zsh";
  };
  programs.home-manager.enable = true;
}
