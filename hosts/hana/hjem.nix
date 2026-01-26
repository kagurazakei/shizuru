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
        "niri/config.kdl".source = lib.mkForce (dot + "/niri/config.kdl");

        "lazygit/config.yml".source = lib.mkForce (dot + "/lazygit/config.yml");

        "carapace/carapace.toml".source =
          lib.mkForce (dot + "/carapace/carapace.toml");

        "nushell/config.nu".source = lib.mkForce (dot + "/nushell/config.nu");

        "nushell/env.nu".source = lib.mkForce (dot + "/nushell/env.nu");

        "nushell/git-status.nu".source =
          lib.mkForce (dot + "/nushell/git-status.nu");

        "wezterm/wezterm.lua".source =
          lib.mkForce (dot + "/wezterm/wezterm.lua");
        "kitty/kitty.conf".source = lib.mkForce (dot + "/kitty/kitty.conf");
        "wezterm/colors/oxocarbon-dark.toml".source =
          lib.mkForce (dot + "/wezterm/colors/oxocarbon-dark.toml");
        # "wezterm/keybinds.lua".source =
        #   lib.mkForce (dot + "/wezterm/keybinds.lua");
        # "wezterm/utils.lua".source =
        #   lib.mkForce (dot + "/wezterm/utils.lua");
        # tmux
        "tmux/tmux.conf".source = lib.mkForce (dot + "/tmux/tmux.conf");
        "tmux/binds.conf".source = lib.mkForce (dot + "/tmux/binds.conf");

        "yazi/init.lua".source = lib.mkForce (dot + "/yazi/init.lua");
        "yazi/yazi.toml".source = lib.mkForce (dot + "/yazi/yazi.toml");
        "yazi/keymap.toml".source = lib.mkForce (dot + "/yazi/keymap.toml");
        "yazi/package.toml".source = lib.mkForce (dot + "/yazi/package.toml");
        "yazi/theme.toml".source = lib.mkForce (dot + "/yazi/theme.toml");
        "yazi/flavors/oxocarbon.yazi/flavor.toml".source =
          lib.mkForce (dot + "/yazi/flavors/oxocarbon.yazi/flavor.toml");
        "yazi/flavors/catppuccin-macchiato.yazi/flavor.toml".source =
          lib.mkForce
          (dot + "/yazi/flavors/catppuccin-macchiato.yazi/flavor.toml");

        ### zellij
        "zellij/config.kdl".source = lib.mkForce (dot + "/zellij/config.kdl");
        "zellij/layouts/default.kdl".source =
          lib.mkForce (dot + "/zellij/layouts/default.kdl");
        "zellij/layouts/nodejs.kdl".source =
          lib.mkForce (dot + "/zellij/layouts/nodejs.kdl");
        "zellij/themes/catppuccin.kdl".source =
          lib.mkForce (dot + "/zellij/themes/catppuccin.kdl");
      };
    };
  };
}
