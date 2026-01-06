{pkgs, ...}: {
  stylix = {
    enable = true;
    autoEnable = false;
    enableReleaseChecks = false;
    homeManagerIntegration = {
      followSystem = true;
      autoImport = true;
    };
  };
  stylix.base16Scheme = ./themes/oxo-draco.yaml;
  stylix = {
    targets = {
      gtk.enable = true;
      qt.enable = false;
      nixos-icons.enable = true;
    };
  };
  stylix.polarity = "dark";
  stylix.image = "/home/antonio/Pictures/wallpapers/.wallpaper";
  stylix = {
    fonts = {
      sizes = {
        terminal = 14;
        applications = 13;
        popups = 13;
      };

      serif = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };

      sansSerif = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };

      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
