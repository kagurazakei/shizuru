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
        neovim = pkgs.neovim.unwrapped.overrideAttrs {
          version = "0.12.0";
          src = pkgs.fetchFromGitHub {
            owner = "neovim";
            repo = "neovim";
            rev = "8499af1119f0f96b4fd57ef9099ce5a2503bc952";
            hash = "sha256-/PyUJOW1PMUdfy+ewWbngxttcaNsQmWpCEueNsAUBZE=";
          };
          doInstallCheck = false;
        };
        inherit (self) vimPlugins;
        startAttrsPlugins = mnw.npinsToPluginsAttrs pkgs ./start-plugins.json;
        optAttrsPlugins = mnw.npinsToPluginsAttrs pkgs ./opt-plugins.json;
        optPlugins = with pkgs.vimPlugins; [
          blink-cmp-avante
          cord-nvim
          blink-cmp-nixpkgs-maintainers
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
