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
      (lib.mkAliasOptionModule ["impure-dots"] ["hjem" "users" "${username}" "impure" "dotsDir"])
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
      ".face.icon".source = "${../../dots/images/profile-2.png}";
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
    "booru/config.toml" = "/booru/config.toml";
    "btop/btop.conf" = "/btop/btop.conf";
    "btop/themes/oxocarbon.theme" = "/btop/themes/oxocarbon.theme";
    "kitty/kitty.conf" = d: d.dotsDir + "/kitty/${d.lib.toLower d.config.networking.hostName}.conf";
    "kitty/themes/oxocarbon.conf" = "/kitty/themes/oxocarbon.conf";
    "carapace/carapace.toml" = "/carapace/carapace.toml";
    "nushell/config.nu" = "/nushell/config.nu";
    "nushell/env.nu" = "/nushell/env.nu";
    "nushell/git-status.nu" = "/nushell/git-status.nu";
  };

  azalea.dots.zakei-gui = mkDotsModule username {
    "uwsm/env" = "/uwsm/env";
    "wallpapers/nix-logo.png" = {config, ...}: config.zaphkiel.data.wallpaper;
    "matugen/config.toml" = "/matugen/config.toml";
    "matugen/templates" = "/matugen/templates";
    "equibop/settings.json" = "/equibop/settings.json";
    "equibop/themes" = "/equibop/themes";
    "fuzzel/fuzzel.ini" = "/fuzzel/fuzzel.ini";
    "fuzzel/noctalia" = "/fuzzel/noctalia";
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
    "mango/animation.conf" = "/mango/animation.conf";
    "mango/bind.conf" = "/mango/bind.conf";
    "mango/config.conf" = "/mango/config.conf";
    "mango/env.conf" = "/mango/env.conf";
    "mango/rules.conf" = "/mango/rules.conf";
    "mango/autostart.sh" = "/mango/autostart.sh";
    "mango/hardware.conf" = d: d.dotsDir + "/mango/${d.lib.toLower d.config.networking.hostName}.conf";
  };

  azalea.dots.zakei-hyprland = mkDotsModule username {
    "hypr/hyprland.conf" = "/hyprland/hyprland.conf";
    "hypr/windowRules.conf" = "/hyprland/windowRules.conf";
    "hypr/keybinds.conf" = "/hyprland/keybinds.conf";
  };
  azalea.dots.zakei-niri = mkDotsModule username {
    "niri/config.kdl" = d: d.dotsDir + "/niri/${d.lib.toLower d.config.networking.hostName}.kdl";
    "noctalia/colors.json" = "/noctalia/colors.json";
    "noctalia/settings.json" = "/noctalia/settings.json";
  };
}
