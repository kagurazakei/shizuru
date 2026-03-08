{
  nur,
  self,
  ...
}: {
  azalea.modules.qt = {
    pkgs,
    config,
    sources,
    ...
  }: let
    username = "antonio";
    system = pkgs.stdenv.hostPlatform.system;
    zpkgs = self.packages.${system};
  in {
    nixpkgs.overlays = [
      nur.overlays.default
    ];
    qt.enable = true;
    environment.systemPackages = with pkgs; [
      zpkgs.qt6ct
      wlsunset
      libqalculate
      (catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "red";
      })
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5ct
      kdePackages.qqc2-desktop-style
      adwaita-qt6
      qt6.qtwayland
      qt6.qtsvg
      qt6Packages.qtstyleplugin-kvantum
      kdePackages.kdialog
      kdePackages.qtpositioning
      kdePackages.qtshadertools
      kdePackages.syntax-highlighting
      kdePackages.qtbase
      kdePackages.qtdeclarative
      kdePackages.qtmultimedia
      kdePackages.qt5compat
      kdePackages.sonnet
      kdePackages.kirigami
      kdePackages.kirigami-addons
      kdePackages.breeze
      (pkgs.callPackage "${sources.noctalia-qs}/default.nix" {})
    ];
    hjem.users.${username}.packages = with pkgs; [
      (catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "red";
      })
    ];
    environment.variables = {
      QT_PLUGIN_PATH = [
        "${pkgs.kdePackages.qqc2-desktop-style}/${pkgs.kdePackages.qtbase.qtPluginPrefix}"
      ];
      QML2_IMPORT_PATH = [
        "${pkgs.kdePackages.qqc2-desktop-style}/${pkgs.kdePackages.qtbase.qtQmlPrefix}"
        "${pkgs.kdePackages.kirigami}/lib/qt-6/qml"
      ];
    };
    hj = {
      xdg.config.files = {
        "qt6ct/qt6ct.conf".source = config.impure-dots + "/qt6ct/qt6ct.conf";
        "qt6ct/colors".source = config.impure-dots + "/qt6ct/colors";
        "qt5ct/qt5ct.conf".source = config.impure-dots + "/qt5ct/qt5ct.conf";
        "qt5ct/colors".source = config.impure-dots + "/qt5ct/colors";
        "Kvantum/kvantum.kvconfig".source = config.impure-dots + "/Kvantum/kvantum.kvconfig";
        "Kvantum/rose-pine-iris".source = config.impure-dots + "/Kvantum/rose-pine-iris";
        "Kvantum/rose-pine-love".source = config.impure-dots + "/Kvantum/rose-pine-love";
      };
    };
  };
}
