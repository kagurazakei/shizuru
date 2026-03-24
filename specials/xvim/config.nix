{
  pkgs,
  lib,
  ...
}: let
  initLua = ../../dots/nvim/init.lua;
in {
  neovim = pkgs.neovim or {};
  luaFiles = [
    initLua
  ];
  extraLuaPackages = _p: [];

  extraBinPath = let
    externalTools =
      {
        inherit
          (pkgs)
          curl
          ripgrep
          imagemagick
          git
          bat
          ;
      }
      // lib.optionalAttrs (lib.meta.availableOn pkgs.stdenv.hostPlatform pkgs.wayland) {
        inherit (pkgs) wl-clipboard;
      };

    formatters = {
      gdscript = pkgs.gdtoolkit_4;
      lua = pkgs.stylua;
      nix = pkgs.nixfmt;
      toml = pkgs.taplo;
      kdl = pkgs.kdlfmt;
      hyprls = pkgs.hyprls;
    };

    languageServers = {
      lua = pkgs.lua-language-server;
      nix = pkgs.nixd;
      toml = pkgs.taplo;
      hyprlang = pkgs.hyprlang;
    };

    pluginDependencies = {
      fzf-lua = pkgs.fzf;
    };
  in
    [
      externalTools
      formatters
      languageServers
      pluginDependencies
    ]
    |> builtins.concatMap builtins.attrValues
    |> lib.flatten
    |> lib.unique;

  providers.python3.enable = true;

  plugins = {
    # injected from default.nix
    startAttrs = pkgs.startAttrsPlugins or {};
    optAttrs = pkgs.optAttrsPlugins or {};
    opt = pkgs.optPlugins or {};
    # treesitter (manual)
    start = let
      nts = pkgs.vimPlugins.nvim-treesitter;
      langs = [
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
        "hyprlang"
        "kdl"
      ];
    in (
      builtins.concatLists (
        map (lang: [
          nts.parsers.${lang}
          nts.queries.${lang}
        ])
        langs
      )
      ++ import ./packages/treesitter.nix {inherit pkgs;}
    );
    dev.config = {
      pure = ../../dots/nvim;
      impure = "/home/antonio/nixos/dots/nvim";
    };
  };
}
