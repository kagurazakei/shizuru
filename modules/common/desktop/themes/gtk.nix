{
  config,
  pkgs,
  theme,
  lib,
  inputs,
  ...
}: let
  inherit (lib.strings) optionalString;
  inherit (builtins) readFile toString;

  packages = {
    theme = pkgs.catppuccin-gtk.override {
      accents = ["pink"];
      variant = "mocha";
      size = "standard";
      tweaks = ["normal"];
    };
    theme-zk = inputs.shizuruPkgs.packages.${pkgs.system}.gtk-themes.CatppuccinMocha-zk;
    theme-rose = pkgs.rose-pine-gtk-theme;
    iconTheme = pkgs.catppuccin-papirus-folders.override {
      accent = "pink";
      flavor = "mocha";
    };
    iconThemeBeauty = inputs.shizuruPkgs.packages.${pkgs.system}.BeautyLine;
    cursorTheme = inputs.waifu-cursors.packages.${pkgs.system}.Reichi-Shinigami;
  };

  cfg = config.hj.rum.misc.gtk;
in {
  hj.rum.misc.gtk = {
    enable = true;
    packages = [
      packages.theme
      packages.theme-zk
      packages.theme-rose
      packages.iconTheme
      packages.iconThemeBeauty
      packages.cursorTheme
    ];
    settings = {
      application-prefer-dark-theme = true;
      theme-name = "catppuccin-mocha-pink-standard+normal";
      icon-theme-name = "BeautyLine";
      font-name = "JetBrainsMono Nerd Font ${toString 13}";
      cursor-theme-name = "Reichi-Shinigami";
    };
    css = let
      darkTheme = cfg.settings.application-prefer-dark-theme;
      fileCSS = ver: "${packages.theme}/share/themes/${cfg.settings.theme-name}/gtk-${ver}/gtk${optionalString darkTheme "-dark"}.css";
    in {
      gtk3 = readFile (fileCSS "3.0");
      gtk4 = readFile (fileCSS "4.0");
    };
  };
}
