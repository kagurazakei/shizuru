{
  pkgs,
  lib,
  ...
}: let
  initLua = ../../dots/nvim/init.lua;

  # Completely explicit collection without map/concat

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

  # Explicit collection
  externalToolsList = builtins.attrValues externalTools;
  formattersList = builtins.attrValues formatters;
  languageServersList = builtins.attrValues languageServers;
  pluginDependenciesList = builtins.attrValues pluginDependencies;

  # Manual concatenation
  allToolsUnflattened =
    externalToolsList ++ formattersList ++ languageServersList ++ pluginDependenciesList;

  # Remove duplicates
  extraBinPath = lib.unique allToolsUnflattened;
in {
  neovim = pkgs.neovim or {};
  luaFiles = [initLua];
  extraLuaPackages = _p: [];

  inherit extraBinPath;

  providers.python3.enable = true;

  plugins = {
    startAttrs = pkgs.startAttrsPlugins or {};
    optAttrs = pkgs.optAttrsPlugins or {};
    opt = pkgs.optPlugins or {};

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
        "kdl"
      ];

      # Explicit foldl for treesitter modules
      treesitterModules =
        builtins.foldl' (
          modules: lang:
            modules
            ++ [
              nts.parsers.${lang}
              nts.queries.${lang}
            ]
        ) []
        langs;

      customPlugins = import ./packages/treesitter.nix {inherit pkgs;};
    in
      treesitterModules ++ customPlugins;

    dev.config = {
      pure = ../../dots/nvim;
      impure = "/home/antonio/nixos/dots/nvim";
    };
  };
}
