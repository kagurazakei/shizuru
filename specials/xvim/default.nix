{
  mnw,
  pkgs,
  callPackage,
  lib,
  sources,
}:
lib.fix (self: {
  vimPlugins = callPackage ./plugins.nix {inherit sources;};

  minimal =
    mnw.wrap (
      pkgs
      // {
        neovim = pkgs.neovim.unwrapped.overrideAttrs (_old: {
          version = "nightly";
          src = sources.neovim;
          doInstallCheck = false;
        });
        inherit (self) vimPlugins;
        startAttrsPlugins = mnw.npinsToPluginsAttrs pkgs ./start-plugins.json;
        optAttrsPlugins = mnw.npinsToPluginsAttrs pkgs ./opt-plugins.json;
        optPlugins = with pkgs.vimPlugins; [
          blink-cmp-avante
          cord-nvim
          blink-cmp
          blink-pairs
          catppuccin-nvim
          base16-nvim
        ];
      }
    )
    ./config.nix;

  default = self.minimal.override (prev: {
    extraBinPath =
      prev.extraBinPath
      ++ [
        pkgs.fzf
        pkgs.hyprlang
        pkgs.npins
        pkgs.kdlfmt
        pkgs.hyprls
        pkgs.prettier
        pkgs.prettierd
      ];
  });
  vivi = self.default.override (prev: {
    luaFiles =
      prev.luaFiles
      ++ [
        (pkgs.writeText "colorscheme.lua" ''
          vim.cmd.colorscheme "tokyonight-night"
        '')
      ];
  });
})
