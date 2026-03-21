# TODO
{
  mnw,
  pkgs,
  lib,
}:
lib.fix (self: {
  minimal = mnw.lib.wrap pkgs ./config.nix;
  default = self.minimal.override (prev: {
    extraBinPath =
      prev.extraBinPath
      ++ [
        # language servers
        pkgs.nil
        pkgs.lua-language-server
        pkgs.kdePackages.qtdeclarative
        # formatter
        pkgs.alejandra
      ];
  });
  vivi = self.default.override (prev: {
    initLua =
      prev.initLua
      + ''
        vim.cmd.colorscheme "tokyonight-night"
      '';
  });
})
