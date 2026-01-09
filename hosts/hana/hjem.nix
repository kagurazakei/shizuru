{
  inputs,
  lib,
  username,
  ...
}: let
  dots = ../../configs;
in {
  imports = [
    inputs.hjem.nixosModules.default
    (lib.modules.mkAliasOptionModule ["hj"] ["hjem" "users" "${username}"])
  ];

  hjem = {
    clobberByDefault = true;

    extraModules = [
      inputs.hjem-rum.hjemModules.default
      inputs.hjem-impure.hjemModules.default
    ];

    users.${username} = {
      enable = true;
      user = username;
      directory = "/home/antonio";

      environment.sessionVariables = {
        NIXPKGS_ALLOW_UNFREE = "1";
      };

      impure = {
        enable = true;
        dotsDir = dots;
        dotsDirImpure = "/home/antonio/shizuru/configs";
      };

      xdg.config.files = {
        "niri/config.kdl".source =
          lib.mkForce (dots + /niri/config.kdl);
        "lazygit/config.yml".source =
          lib.mkForce (dots + /lazygit/config.yml);
      };
    };
  };
}
