# TODO
{
  mnw,
  pkgs,
  callPackage,
  lib,
  sources,
}: let
  initLua = ../../dots/nvim/init.lua;
  externalTools =
    {
      inherit (pkgs) curl ripgrep imagemagick;
    }
    // lib.optionalAttrs (lib.meta.availableOn pkgs.stdenv.hostPlatform pkgs.wayland) {
      inherit (pkgs) wl-clipboard;
    };

  formatters = {
    gdscript = pkgs.gdtoolkit_4;
    lua = pkgs.stylua;
    nix = pkgs.nixfmt;
    toml = pkgs.taplo;
  };

  languageServers = {
    lua = pkgs.lua-language-server;
    nix = pkgs.nixd;
    toml = pkgs.taplo;
  };

  pluginDependencies = {
    fzf-lua = pkgs.fzf;
  };

  extraBinPath =
    [
      formatters
      languageServers
      pluginDependencies
      externalTools
    ]
    |> builtins.concatMap builtins.attrValues
    |> lib.flatten
    |> lib.unique;
in
  lib.fix (self: {
    vimPlugins = callPackage ./plugins.nix {inherit sources;};
    minimal = mnw.wrap pkgs {
      appName = "nvim";
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

      luaFiles = [
        initLua
      ];

      plugins = {
        startAttrs = mnw.npinsToPluginsAttrs pkgs ./start-plugins.json;
        start =
          import ./packages/treesitter.nix {inherit pkgs;}
          ++ (
            let
              langs =
                [
                  "bash"
                  "comment"
                  "diff"
                  "json"
                  "just"
                  "markdown"
                  "nix"
                  "query"
                  "regex"
                  "toml"
                  "yaml"
                  "zsh"
                  "hyprlang"
                ]
                ++ [
                  "git_config"
                  "git_rebase"
                  "gitattributes"
                  "gitcommit"
                  "gitignore"
                  "gdscript"
                  "gdshader"
                  "godot_resource"
                  "lua"
                  "luadoc"
                  "luap"
                  "vim"
                  "vimdoc"
                ];
            in
              langs
              |> builtins.concatMap (lang: [
                pkgs.vimPlugins.nvim-treesitter.parsers.${lang}
                pkgs.vimPlugins.nvim-treesitter.queries.${lang}
              ])
          );
        optAttrs =
          {
            "blink.cmp" = pkgs.vimPlugins.blink-cmp;
            "cord.nvim" = pkgs.vimPlugins.cord-nvim;
          }
          // mnw.npinsToPluginsAttrs pkgs ./opt-plugins.json;
        dev.config = {
          pure = ../../dots/nvim;
          impure = "/home/antonio/nixos/dots/nvim"; # Absolute path needed
        };
      };
    };
    default = self.minimal.override (_prev: {
      extraBinPath = extraBinPath ++ (with pkgs; [fzf]);
    });
    vivi = self.default.override (prev: {
      initLua =
        prev.initLua
        + ''
          vim.cmd.colorscheme "tokyonight-night"
        '';
    });
  })
