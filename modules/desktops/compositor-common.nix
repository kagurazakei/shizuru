{
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
    todo = hs-todo.packages.${system}.default;
    noRounding = ''
      * {
                border-radius: 0px !important;
        }
      window {
                border-radius: 0px !important;
             }
      window, decoration, decoration-overlay, headerbar, .titlebar {
          border-radius: 0px !important;
          border-bottom-left-radius: 0px !important;
          border-bottom-right-radius: 0px !important;
          border-top-left-radius: 0px !important;
          border-top-right-radius: 0px !important;
      }
    '';
  in {
    nixpkgs.overlays = [
      nur.overlays.default
    ];
    # for whatever reason swappy likes to open images
    # don't let that fucker open images
    hj = {
      xdg.config.files."gtk-4.0/gtk.css".text = noRounding;
      xdg.config.files."gtk-3.0/gtk.css".text = noRounding;
    };
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
        (pkgs.zpkgs)
        kokCursor
        # stash
        viu
        equibop
        wayle
        ;
      inherit
        (pkgs.zpkgs.scripts)
        taildrop
        gpurecording
        cowask
        npins-show
        wallcrop
        nixy
        lutui
        npins-helper
        npins-ui
        touchpad-toggle
        ;
      # Themes
      inherit
        (pkgs)
        gtk3
        gtk4
        gtk-engine-murrine
        rose-pine-icon-theme
        rose-pine-gtk-theme
        libadwaita
        ;
      inherit (pkgs.kdePackages) breeze breeze-icons;
      inherit
        (pkgs)
        ayugram-desktop
        wl-clipboard
        cliphist
        mpvpaper
        findutils
        gtkmm4
        grim
        slurp
        qimgv
        brightnessctl
        duf
        lazygit
        gpu-screen-recorder
        ;
      inherit (pkgs.master) trashy fuzzel wl-screenrec;
      inherit
        (pkgs)
        libnotify
        swappy
        imv
        wayfreeze
        networkmanagerapplet
        ;
      inherit
        (pkgs.stable)
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
        ollama
        proton-vpn
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
            cursor-theme = "Kureiji-Ollie-v2";
            gtk-theme = "oomox-snazzy";
            icon-theme = "Catppuccin-SE";
            document-font-name = "JetBrainsMono Nerd Font";
            font-name = "JetBrainsMono Nerd Font";
            monospace-font-name = "JetBrainsMono Nerd Font";
            accent-color = "red";
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
