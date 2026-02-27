{
  azalea.modules.dolphin = {
    pkgs,
    config,
    ...
  }: {
    hj = {
      packages = with pkgs.kdePackages; [
        dolphin
        dolphin-plugins
        gwenview
        ark
        kservice
        kde-cli-tools
        ffmpegthumbs
        kio
        kio-extras
        kio-fuse
        kimageformats
        kdegraphics-thumbnailers
        kirigami
      ];
      xdg.config.files = {
        "dolphinrc".source = config.hj.impure.dotsDir + "/dolphinrc";
        "menus/applications.menu".source = config.hj.impure.dotsDir + "/menus/applications.menu";
        "kdeglobals".source = config.hj.impure.dotsDir + "/kdeglobals";
      };
    };
  };
}
