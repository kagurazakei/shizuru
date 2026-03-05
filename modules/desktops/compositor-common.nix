{
  self,
  hs-todo,
  nur,
  ...
}: {
  azalea.modules.compositor-common = {
    pkgs,
    lib,
    ...
  }: let
    inherit (lib) mkForce attrValues;

    system = pkgs.stdenv.hostPlatform.system;
    zpkgs = self.packages.${system};
    todo = hs-todo.packages.${system}.default;
  in {
    nixpkgs.overlays = [
      nur.overlays.default
    ];
    # for whatever reason swappy likes to open images
    # don't let that fucker open images
    xdg.mime.defaultApplications = {
      "image/jpeg" = ["imv.desktop"];
      "image/png" = ["imv.desktop"];
      "application/pdf" = ["librewolf.desktop"];
    };

    services.gnome.gnome-keyring.enable = true;

    # required for mounting mobile phones
    services.gvfs.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower = {
      enable = true;
      usePercentageForPolicy = true;
      criticalPowerAction = "PowerOff";
    };

    # dependencies .w.
    environment.systemPackages = attrValues {
      # internal overlay
      inherit
        (zpkgs)
        kokCursor
        stash
        viu
        equibop
        nirinit
        gtk-themes
        niri-scratchpad-rs
        ktop
        ;
      inherit
        (zpkgs.scripts)
        taildrop
        gpurecording
        cowask
        npins-show
        wallcrop
        nixy
        lutui
        ;
      # Themes
      inherit
        (pkgs)
        gtk3
        gtk4
        gtk-engine-murrine
        rose-pine-icon-theme
        rose-pine-gtk-theme
        ;
      inherit (pkgs.kdePackages) breeze;
      # utility
      inherit
        (pkgs)
        ayugram-desktop
        wl-clipboard
        grim
        slurp
        qimgv
        brightnessctl
        duf
        lazygit
        gpu-screen-recorder
        ;
      inherit (pkgs) trashy fuzzel wl-screenrec;
      inherit
        (pkgs)
        libnotify
        swappy
        imv
        wayfreeze
        networkmanagerapplet
        bottom
        nitch
        fastfetch
        htop
        ;
      inherit
        (pkgs)
        yazi
        ripdrag
        seahorse
        app2unit
        komikku
        quickshell
        ;
      inherit (pkgs) foot libsixel kitty;
      # external
      inherit todo;
    };
    programs.dconf.enable = true;
    programs.dconf.profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            cursor-theme = "Kokomi-Cursor";
            gtk-theme = "rose-pine";
            icon-theme = "rose-pine";
            document-font-name = "JetBrainsMono Nerd Font";
            font-name = "JetBrainsMono Nerd Font";
            monospace-font-name = "JetBrainsMono Nerd Font";
            accent-color = "purple";
            color-scheme = "prefer-dark";
          };
        };
      }
    ];

    services.hypridle.enable = true;
    systemd.user.services.hypridle.path = mkForce (attrValues {
      inherit (pkgs) systemd procps brightnessctl;
    });
  };
}
