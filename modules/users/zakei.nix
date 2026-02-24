{self, ...}: let
  inherit (self.lib) mkDotsModule;
  username = "antonio";
in {
  azalea.users.zakei = {
    pkgs,
    config,
    lib,
    ...
  }: {
    imports = [
      (lib.mkAliasOptionModule ["hj"] ["hjem" "users" "${username}"])
    ];
    zaphkiel = {
      data.users = [username];
    };

    users.users.${username} = {
      description = "Kagurazakei";
      shell = pkgs.fish;
      isNormalUser = true;
      extraGroups = [
        "networkmanager"
        "wheel"
        "multimedia"
        "video"
        "inputs"
        "audio"
      ];
      hashedPasswordFile = config.age.secrets.antonioPass.path;

      # only declare common packages here
      # others: hosts/<hostname>/user-configuration.nix
      # if you declare something here that isn't common to literally every host I
      # will personally show up under your bed whoever and wherever you are
      packages = [
        pkgs.btop
        pkgs.git
        pkgs.bat
        pkgs.delta
        pkgs.git-lfs
      ];

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEaNh2GVxWz2zLxDa8cMnPtfYQPk1A3xlKKVuKOTNrp2 antonio@hana"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINjywfRHVDeBQBFYZym/c3JDVRwni//tSy5FPKmTgLyN antonio@hana"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDT989Rm6vSVS4cSP2NevoXVS7UnFVYHgfsE6dbM2+s6 hana@antonio"
      ];
    };

    hj.files = {
      ".face.icon".source = "${../../dots/profile.png}";
    };
    systemd.tmpfiles.rules = [
      # AccountsService user file
      "f+ /var/lib/AccountsService/users/${username} 0600 root root - \
[User]\nIcon=/var/lib/AccountsService/icons/${username}\n"

      # Symlink icon
      "L+ /var/lib/AccountsService/icons/${username} - - - - ${config.hj.files.".face.icon".source}"
    ];
    hjem.users.${username} = {
      enable = true;
      user = username;
      directory = config.users.users.${username}.home;
      clobberFiles = lib.mkForce true;

      impure = {
        enable = true;
        dotsDir = "${self.paths.dots}";
        dotsDirImpure = "/home/antonio/nixos/dots";
        # skips parsing hjem.users.<>.files
        parseAttrs = [
          config.hjem.users.${username}.xdg.config.files
          config.hjem.users.${username}.xdg.state.files
        ];
      };
    };
  };

  # being able to nix freely
  # I have spawned horrors upon this world
  # nix beginners, I am sorry

  azalea.dots.zakei-cli = mkDotsModule username {
    # terminal
    # NOTE: required bat cache --build before theme can be used
    "bat/config" = "/bat/config";
    "bat/themes" = {sources, ...}: sources.catp-bat + "/themes";
    "shpool/config.toml" = "/shpool/config.toml";
    "yazi/yazi.toml" = "/yazi/yazi.toml";
    "yazi/keymap.toml" = "/yazi/keymap.toml";
    "booru/config.toml" = "/booru/config.toml";

    "fish/config.fish" = "/fish/config.fish";
    "fish/user_variables.fish" = "/fish/user_variables.fish";
    "fish/abbreviations.fish" = "/fish/abbreviations.fish";
    "fish/aliases.fish" = "/fish/aliases.fish";
    "kitty/kitty.conf" = "/kitty/kitty.conf";
    "kitty/themes/oxocarbon.conf" = "/kitty/themes/oxocarbon.conf";
    "menus/applications.menu" = "/menus/applications.menu";
    "dolphinrc" = "/dolphinrc";
    "carapace/carapace.toml" = "/carapace/carapace.toml";
    "nushell/config.nu" = "/nushell/config.nu";
    "nushell/env.nu" = "/nushell/env.nu";
    "nushell/git-status.nu" = "/nushell/git-status.nu";
  };

  azalea.dots.zakei-gui = mkDotsModule username {
    "uwsm/env" = "/uwsm/env";
    "dolphinrc" = "/dolphinrc";
    "qt6ct/qt6ct.conf" = "/qt6ct/qt6ct.conf";
    "background" = {config, ...}: config.zaphkiel.data.wallpaper;
    "matugen/config.toml" = "/matugen/config.toml";
    "matugen/templates" = "/matugen/templates";
    "fuzzel/fuzzel.ini" = "/fuzzel/fuzzel.ini";
    "foot/foot.ini" = "/foot/foot.ini";
    "foot/rose-pine.ini" = {sources, ...}: sources.rosep-foot + "/rose-pine";
    "hypr/hypridle.conf" = "/hyprland/hypridle.conf";
    "gtk-4.0/settings.ini" = "/gtk/gtk4.ini";
    "yazi/init.lua" = "/yazi/init.lua";
    "yazi/yazi.toml" = "/yazi/yazi.toml";
    "yazi/keymap.toml" = "/yazi/keymap.toml";
    "yazi/package.toml" = "/yazi/package.toml";
    "yazi/theme.toml" = "/yazi/theme.toml";
    "yazi/flavors/oxocarbon.yazi/flavor.toml" = "/yazi/flavors/oxocarbon.yazi/flavor.toml";
    "yazi/flavors/catppuccin-macchiato.yazi/flavor.toml" = "/yazi/flavors/catppuccin-macchiato.yazi/flavor.toml";
    "zellij/config.kdl" = "/zellij/config.kdl";
    "zellij/layouts/default.kdl" = "/zellij/layouts/default.kdl";
    "zellij/layouts/nodejs.kdl" = "/zellij/layouts/nodejs.kdl";
    "zellij/themes/catppuccin.kdl" = "/zellij/themes/catppuccin.kdl";
    "fcitx5/conf/classicui.conf" = "/fcitx5/classicui.conf";
  };

  azalea.dots.zakei-mango = mkDotsModule username {
    "mango/config.conf" = "/mango/config.conf";
    "mango/autostart.sh" = "/mango/autostart.sh";
    "mango/hardware.conf" = d: d.dotsDir + "/mango/${d.lib.toLower d.config.networking.hostName}.conf";
  };

  azalea.dots.zakei-hyprland = mkDotsModule username {
    "hypr/hyprland.conf" = "/hyprland/hyprland.conf";
  };
  azalea.dots.zakei-niri = mkDotsModule username {
    "niri/config.kdl" = d: d.dotsDir + "/niri/${d.lib.toLower d.config.networking.hostName}.kdl";
    "noctalia/colors.json" = "/noctalia/colors.json";
    "noctalia/settings.json" = "/noctalia/settings.json";
  };
}
