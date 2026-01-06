{
  pkgs,
  lib,
  ...
}: let
  inherit (import ./variables.nix) keyboardLayout;
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery
      ]
  );
in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./hjem.nix
    ./themes.nix
    ../../modules/options/hana.nix
  ];
  stylix.enableReleaseChecks = false;
  services.xserver.videoDrivers = ["modesetting" "nvidia"];
  catppuccin.tty.enable = false;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  nixpkgs.config = {
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["joypixels"];
    joypixels.acceptLicense = true;
  };
  environment.systemPackages =
    (with pkgs; [
      libva-utils
      libvdpau-va-gl
      libva-vdpau-driver
      egl-wayland
      mesa
      master.waybar
    ])
    ++ [python-packages];
  hardware.graphics.enable = true;
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = ["/"];
  };
  console.keyMap = "${keyboardLayout}";
  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    VISUAL = "vscodium";
    GSK_RENDERER = "gl";
    NIXPKGS_ALLOW_UNFREE = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    ZDOTDIR = "$HOME/.config/zsh";
    NH_OS_FLAKE = "/home/antonio/shizuru";
  };
  system.stateVersion = "25.05";
}
