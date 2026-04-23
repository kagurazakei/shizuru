{self, ...}: {
  azalea.modules.environment = {
    pkgs,
    sources,
    flakeCompat,
    ...
  }: let
    neovim-nightly = (flakeCompat.flakeToNix {src = sources.neovim-nightly;}).defaultNix;
  in {
    nixpkgs.overlays = [
      neovim-nightly.overlays.default
    ];
    environment.systemPackages = with pkgs; [
      stable.git
      gh
      neovide
      (callPackage "${sources.npins}/npins.nix" {})
      alejandra
      (self.lib.mkPkgx' pkgs).xvim.default
    ];

    environment.variables.EDITOR = "nvim";
    environment.variables.MANPAGER = "nvim +Man!";
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    # nano deez nutz
    programs.nano.enable = false;
    environment.sessionVariables = {
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_STATE_HOME = "$HOME/.local/state";
      XDG_BIN_HOME = "$HOME/.local/bin";
    };
  };
}
