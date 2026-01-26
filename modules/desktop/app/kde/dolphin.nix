{
  inputs,
  pkgs,
  ...
}: {
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
        inputs.shizuruPkgs.packages.${pkgs.system}.catppuccin-icons
        pkgs.candy-icons
        pkgs.zafiro-icons
      ];
  };
}
