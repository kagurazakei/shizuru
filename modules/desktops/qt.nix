{
  nur,
  self,
  ...
}: {
  azalea.modules.qt = {
    pkgs,
    config,
    ...
  }: let
    username = "antonio";
  in {
    nixpkgs.overlays = [
      nur.overlays.default
    ];
    qt.enable = true;
    environment.systemPackages = with pkgs; [
      self.packages.${pkgs.stdenv.hostPlatform.system}.qt6ct
      wlsunset
      libqalculate
      quickshell
      (catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "red";
      })
    ];
    hjem.users.${username}.packages = with pkgs; [
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
      kdePackages.syntax-highlighting
      kdePackages.qtbase
      kdePackages.qtdeclarative
      kdePackages.qtmultimedia
      kdePackages.qt5compat
      kdePackages.sonnet
      kdePackages.kirigami
      kdePackages.kirigami-addons
      kdePackages.breeze
      quickshell
    ];
    environment.variables = {
      QT_PLUGIN_PATH = [
        "${pkgs.kdePackages.qqc2-desktop-style}/${pkgs.kdePackages.qtbase.qtPluginPrefix}"
      ];
      QML2_IMPORT_PATH = [
        "${pkgs.kdePackages.qqc2-desktop-style}/${pkgs.kdePackages.qtbase.qtQmlPrefix}"
      ];
    };
    hj = {
      xdg.config.files = {
        "qt6ct/qt6ct.conf".source = config.hj.impure.dotsDir + "/qt6ct/qt6ct.conf";
        "qt6ct/colors".source = config.hj.impure.dotsDir + "/qt6ct/colors";
        "qt5ct/qt5ct.conf".source = config.hj.impure.dotsDir + "/qt5ct/qt5ct.conf";
        "qt5ct/colors".source = config.hj.impure.dotsDir + "/qt5ct/colors";
        "Kvantum/kvantum.kvconfig".source = config.hj.impure.dotsDir + "/Kvantum/kvantum.kvconfig";
        "Kvantum/rose-pine-iris".source = config.hj.impure.dotsDir + "/Kvantum/rose-pine-iris";
      };
    };
  };
}
