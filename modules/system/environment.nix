{zakeivim, ...}: {
  azalea.modules.environment = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.git
      pkgs.gh
      pkgs.npins
      pkgs.alejandra
      zakeivim.packages.${pkgs.stdenv.hostPlatform.system}.khanelivim
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
