{ self, ... }:
{
  azalea.modules.fonts =
    {
      pkgs,
      lib,
      ...
    }:
    {
      fonts = {
        fontDir.enable = true;
        fontconfig = {
          defaultFonts = {
            serif = [
              "JetBrainsMono Nerd Font"
            ];
            sansSerif = [
              "JetBrainsMono Nerd Font"
            ];
            monospace = [
              "JetBrainsMono Nerd Font"
            ];
          };
        };
        packages = lib.attrValues {
          inherit (pkgs.nerd-fonts) jetbrains-mono caskaydia-mono caskaydia-cove;
          inherit (pkgs)
            noto-fonts
            noto-fonts-color-emoji
            noto-fonts-cjk-sans
            material-design-icons
            font-awesome
            ttf_bitstream_vera
            source-code-pro
            carlito
            dejavu_fonts
            ipafont
            kochi-substitute
            ;
          inherit (pkgs) noto-fonts-cjk-serif material-symbols iosevka;
          inherit (self.packages.${pkgs.stdenv.hostPlatform.system}) librebarcode;
        };
      };
    };
}
