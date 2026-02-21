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
  };
}
