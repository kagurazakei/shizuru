{
  pkgs,
  mnw,
  small ? false,
}: let
  args = {inherit pkgs;};
in
  mnw.lib.wrap pkgs {
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
      ./init.lua
    ];

    plugins = {
      startAttrs = import ./packages/startPlugins.nix args;
      start = import ./packages/treesitter.nix args;
      optAttrs = mnw.lib.npinsToPluginsAttrs pkgs ./opt.json;
      dev.config = {
        pure = ../../dots/nvim;
        impure = "/home/antonio/nixos/dots/nvim"; # Absolute path needed
      };
    };
    extraBinPath =
      import ./packages/binaries.nix args
      ++ (
        if small
        then []
        else import ./packages/extraBinaries.nix args
      );
  }
