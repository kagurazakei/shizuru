{
  inputs,
  pkgs,
  ...
}: let
  catppuccin-kde-mocha = pkgs.catppuccin-kde.override {
    flavour = ["mocha"];
    accents = ["red"];
  };
in {
  # programs.qtengine = {
  #   enable = true;
  #
  #   config = {
  #     theme = {
  #       colorScheme = "${catppuccin-kde-macchiato}/share/color-schemes/CatppuccinMacchiatoMauve.colors";
  #       iconTheme = "Papirus-Dark";
  #       style = "Darkly";
  #
  #       font = {
  #         family = "Noto Sans";
  #         size = 11;
  #         weight = -1;
  #       };
  #
  #       fontFixed = {
  #         family = "JetBrainsMono Nerd Font";
  #         size = 11;
  #         weight = -1;
  #       };
  #     };
  #
  #     misc = {
  #       singleClickActivate = false;
  #       menusHaveIcons = true;
  #       shortcutsForContextMenus = true;
  #     };
  #   };
  # };
  hj = {
    packages = with pkgs.kdePackages;
      [
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
      ]
      ++ [
        inputs.shizuruPkgs.packages.${pkgs.stdenv.hostPlatform.system}.catppuccin-icons
        pkgs.candy-icons
        pkgs.zafiro-icons
      ];
  };
}
