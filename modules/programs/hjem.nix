{
  azalea.modules.hjem = {
    pkgs,
    lib,
    sources,
    flakeCompat,
    pins,
    ...
  }: let
    qtengineOut = flakeCompat._flakeToNix {
      src = sources.qtengine;
      overrides = {
        nixpkgs = pkgs.path; # all qt apps need "follows"
      };
    };
  in {
    imports = [pins.hjem.nixosModules.default];
    hjem = {
      linker = lib.mkForce pins.hjem.packages.${pkgs.stdenv.hostPlatform.system}.smfh;
      extraModules = [
        qtengineOut.hjemModules.default
      ];
      users.antonio = {
        programs.qtengine = {
          enable = true;
          config = {
            theme = {
              colorScheme = "Noctalia";
              iconTheme = "oomox-tokyodark-terminal";
              style = "qt6-style";

              font = {
                family = "JetBrainsMono Nerd Font";
                size = 14;
                weight = -1;
              };

              fontFixed = {
                family = "JetBrainsMono Nerd Font";
                size = 13;
                weight = -1;
              };
            };
            misc = {
              singleClickActivate = false;
              menusHaveIcons = true;
              shortcutsForContextMenus = true;
            };
          };
        };
      };
    };
  };
}
