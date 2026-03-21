{
  lib,
  stdenv,
  nixpkgs,
  nixCats,
  neovim-nightly,
  ...
} @ args: let
  # Check if neovim-nightly is provided, if not, try to get it from pkgs or use a default
  neovim-nightly-input =
    if args ? neovim-nightly
    then neovim-nightly
    else null;

  # If neovim-nightly is not provided, we need to import it
  neovim-nightly-overlay =
    if neovim-nightly-input != null
    then neovim-nightly-input
    else (import (fetchTarball "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz") {}).overlays.default;

  # Import nixpkgs with necessary overlays

  # Define the same categories as in the flake
  categoryDefinitions = {pkgs, ...}: {
    lspsAndRuntimeDeps = {
      general = with pkgs;
        [
          nixd
          stdenv.cc.cc
          lua-language-server
          ripgrep
          gopls
          yaml-language-server
          terraform-ls
          nix-doc
          stylua
          yamlfmt
          yamllint
          prettierd
          shfmt
          commitlint
          kustomize
          kubeconform
          kubent
          glab
        ]
        ++ lib.optionals (pkgs ? claude-code) [pkgs.claude-code];
    };

    sharedLibraries = {
      general = with pkgs; [
        lazygit
        kubernetes-helm
      ];
    };

    environmentVariables = {
      test = {
        CATTESTVAR = "It worked!";
      };
    };

    extraWrapperArgs = {
      test = [
        ''--set CATTESTVAR2 "It worked again!"''
      ];
    };
  };

  packageDefinitions = {
    nvim = {...}: {
      settings = {
        wrapRc = true;
        aliases = ["vim" "nv"];
      };
      categories = {
        general = true;
        gitPlugins = true;
        customPlugins = true;
        test = true;
        example = {
          youCan = "add more than just booleans";
          toThisSet = [
            "and the contents of this categories set"
            "will be accessible to your lua with"
            "nixCats('path.to.value')"
          ];
        };
      };
    };
  };

  # Build the Neovim configuration
  nvim =
    nixCats.utils.baseBuilder (toString ./.) {
      inherit nixpkgs;
      system = stdenv.hostPlatform.system;
      dependencyOverlays = [
        neovim-nightly-overlay
        (nixCats.utils.standardPluginOverlay {inherit nixpkgs;})
      ];
      extra_pkg_config = {
        allowUnfree = true;
      };
    }
    categoryDefinitions
    packageDefinitions "nvim";
in
  nvim
