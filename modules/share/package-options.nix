{
  pkgs,
  config,
  options,
  lib,
  inputs,
  system,
  ...
}:
with lib; let
  swww = inputs.swww.packages.${pkgs.stdenv.hostPlatform.system}.swww;
  cfg = config.system.packages;
in {
  options.system.packages = {
    enable = mkEnableOption "Enable Laptop Specific Packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      brightnessctl # for brightness control
      python313Packages.pywayland
      neovide
      cliphist
      eog
      gnome-system-monitor
      file-roller
      grim
      gtk-engine-murrine # for gtk themes
      hyprcursor # requires unstable channel
      imagemagick
      inxi
      jq
      nwg-look # requires unstable channel
      nwg-dock-hyprland
      master.pamixer
      master.nushell
      pavucontrol
      playerctl
      polkit_gnome
      pyprland
      python313Packages.kde-material-you-colors
      rofi
      slurp
      swappy
      swww
      unzip
      wallust
      wl-clipboard
      yad
      yt-dlp
      nix-ld
      power-profiles-daemon
      fd
      master.home-manager
      master.waypaper
      bluez-tools
      wgpu-utils
      gtk3
      gtk4
      atuin
      zoxide
      dart-sass
      sass
      wf-recorder
      sassc
      libgtop
      telegram-desktop
      #papirus-folders
      papirus-icon-theme
      joypixels
      spotify
      gpu-screen-recorder
      libqalculate
      dbus-glib
      gtkmm4
      #master.komikku
      mangal
      #   mangareader
      master.tmux
      #  neofetch
      gtk4
      vivid
      #      inputs.shizuruPkgs.packages.${pkgs.system}.nitch
      #      inputs.shizuruPkgs.packages.${pkgs.system}.idle-inhibit
      #      inputs.shizuruPkgs.packages.${pkgs.system}.rxfetch
      inputs.fastanime.packages.${pkgs.stdenv.hostPlatform.system}.default
      nurl
      inputs.hyprsunset.packages.${pkgs.stdenv.hostPlatform.system}.hyprsunset
      master.microfetch
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      socat
      hyprpicker
      #    master.ani-cli
      zellij
    ];
  };
}
