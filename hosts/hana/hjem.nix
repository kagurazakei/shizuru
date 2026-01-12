{
  inputs,
  lib,
  username,
  config,
  ...
}: let
  dots = "${../../configs}";
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

      impure = {
        enable = true;
        dotsDir = dots;
        dotsDirImpure = "/home/antonio/shizuru/configs";
      };

      xdg.config.files = let
        dot = config.hjem.users.${username}.impure.dotsDir;
      in {
        "niri/config.kdl".source =
          lib.mkForce (dot + "/niri/config.kdl");

        "lazygit/config.yml".source =
          lib.mkForce (dot + "/lazygit/config.yml");

        "carapace/carapace.toml".source =
          lib.mkForce (dot + "/carapace/carapace.toml");

        "nushell/config.nu".source =
          lib.mkForce (dot + "/nushell/config.nu");

        "nushell/env.nu".source =
          lib.mkForce (dot + "/nushell/env.nu");

        "nushell/git-status.nu".source =
          lib.mkForce (dot + "/nushell/git-status.nu");

        "wezterm/wezterm.lua".source =
          lib.mkForce (dot + "/wezterm/wezterm.lua");
        # "wezterm/bar.lua".source =
        #   lib.mkForce (dot + "/wezterm/bar.lua");
        # "wezterm/catppuccin.lua".source =
        #   lib.mkForce (dot + "/wezterm/catppuccin.lua");
        # "wezterm/keybinds.lua".source =
        #   lib.mkForce (dot + "/wezterm/keybinds.lua");
        # "wezterm/utils.lua".source =
        #   lib.mkForce (dot + "/wezterm/utils.lua");

        "yazi/init.lua".source =
          lib.mkForce (dot + "/yazi/init.lua");
        "yazi/yazi.toml".source =
          lib.mkForce (dot + "/yazi/yazi.toml");
        "yazi/keymap.toml".source =
          lib.mkForce (dot + "/yazi/keymap.toml");
        "yazi/package.toml".source =
          lib.mkForce (dot + "/yazi/package.toml");
        "yazi/theme.toml".source =
          lib.mkForce (dot + "/yazi/theme.toml");
        "yazi/flavors/catppuccin-macchiato.yazi/flavor.toml".source =
          lib.mkForce (dot + "/yazi/flavors/catppuccin-macchiato.yazi/flavor.toml");
      };
    };
  };
}
