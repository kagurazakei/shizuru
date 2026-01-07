{
  description = "MaotseNyein NixOS-Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    font-flake.url = "github:redyf/font-flake";
    systems.url = "github:nix-systems/x86_64-linux";
    #agenix.url = "github:ryantm/agenix";
    dms.url = "github:AvengeMedia/DankMaterialShell";
    walker.url = "github:abenz1267/walker/v0.13.26";
    #    private-key.url = "git+ssh://git@codeberg.org/maotseantonio/secrets.git";
    nix-monitor = {
      url = "github:antonjah/nix-monitor";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra.url = "github:kamadorueda/alejandra/4.0.0";
    alejandra.inputs.nixpkgs.follows = "nixpkgs";
    noctalia-shell.url = "github:noctalia-dev/noctalia-shell";
    fastanime.url = "github:Benexl/FastAnime";
    fish-flake = {
      url = "github:kagurazakei/fish-flake";
    };
    silentSDDM = {
      url = "github:kagurazakei/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    shizuruPkgs.url = "github:kagurazakei/shizuruPkgs";
    kureiji-ollie-cursor.url = "github:kagurazakei/kureiji-ollie-cursors";
    waifu-cursors.url = "git+https://codeberg.org/maotseantonio/waifu-cursors";
    caelestia = {
      url = "github:kagurazakei/shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
    };
    app2unit = {
      url = "github:soramanew/app2unit";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # lix-module = {
    #   url = "git+https://git.lix.systems/lix-project/nixos-module?ref=main&rev=4d4c2b8f0a801c91ce5b717c77fe3a17efa1402f";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.lix = {
    #     url = "git+https://git.lix.systems/lix-project/lix?ref=main&rev=cad6118e20a520b7536879d951ab6c3228b3e111";
    #     inputs.nixpkgs.follows = "nixpkgs";
    #   };
    # };
    # flake-programs-sqlite = {
    #   url = "github:wamserma/flake-programs-sqlite";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-anywhere = {
      url = "github:numtide/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.disko.follows = "disko";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nvchad4nix = {
      url = "github:MOIS3Y/nvchad4nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen = {
      url = "github:/InioX/Matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi.url = "github:sxyazi/yazi";

    aquamarine = {
      url = "github:hyprwm/aquamarine";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        hyprutils.follows = "hyprutils";
        hyprwayland-scanner.follows = "hyprwayland-scanner";
      };
    };

    hyprcursor = {
      url = "github:hyprwm/hyprcursor";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        hyprlang.follows = "hyprlang";
      };
    };

    hyprgraphics = {
      url = "github:hyprwm/hyprgraphics";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        hyprutils.follows = "hyprutils";
      };
    };

    hyprland-protocols = {
      url = "github:hyprwm/hyprland-protocols";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    hyprland-qtutils = {
      url = "github:hyprwm/hyprland-qtutils";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        hyprlang.follows = "hyprlang";
      };
    };

    hyprlang = {
      url = "github:hyprwm/hyprlang";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        hyprutils.follows = "hyprutils";
      };
    };

    hyprutils = {
      url = "github:hyprwm/hyprutils";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    hyprwayland-scanner = {
      url = "github:hyprwm/hyprwayland-scanner";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    xdph = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        hyprland-protocols.follows = "hyprland-protocols";
        hyprlang.follows = "hyprlang";
        hyprutils.follows = "hyprutils";
        hyprwayland-scanner.follows = "hyprwayland-scanner";
      };
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        aquamarine.follows = "aquamarine";
        hyprcursor.follows = "hyprcursor";
        hyprgraphics.follows = "hyprgraphics";
        hyprland-protocols.follows = "hyprland-protocols";
        hyprlang.follows = "hyprlang";
        hyprutils.follows = "hyprutils";
        hyprwayland-scanner.follows = "hyprwayland-scanner";
        xdph.follows = "xdph";
      };
    };
    hypridle.url = "github:hyprwm/hypridle";
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprsunset.url = "github:hyprwm/hyprsunset";
    hyprland-qt-support.url = "github:hyprwm/hyprland-qt-support";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # hyprpanel = {
    #   url = "github:Jas-SinghFSU/HyprPanel";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    hyprscroller = {
      url = "github:cpiber/hyprscroller";
      inputs.hyprland.follows = "hyprland";
    };

    niri.url = "github:Naxdy/niri";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agsv1 = {
      url = "github:dtomvan/agsv1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lunarsLib = {
      url = "github:lunarnovaa/lunarslib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
    };

    #chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    # chaotic.url = "github:chaotic-cx/nyx/main";
    chaotic.url = "github:lonerOrz/nyx-loner";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    catppuccin.url = "github:catppuccin/nix";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    nvchad-on-steroids = {
      url = "github:kagurazakei/nvchad-on-steroids";
      flake = false;
    };

    wayland-pipewire-idle-inhibit = {
      url = "git+https://codeberg.org/maotseantonio/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ghostty.url = "github:ghostty-org/ghostty";
    #nixcord.url = "github:kaylorben/nixcord";
    nixcord.url = "github:kaylorben/nixcord?rev=f93293513fdf2a5d530e3c3bce9cc87bd9b47b2a";
    textfox.url = "github:adriankarlen/textfox";
    nh = {
      url = "github:nix-community/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swww = {
      url = "github:LGFae/swww/v0.10.3";
    };

    sddm-stray.url = "git+https://codeberg.org/maotseantonio/sddm-stray-flakes";
    nix-alien.url = "github:thiagokokada/nix-alien";
    wezterm.url = "github:wezterm/wezterm?dir=nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nyxexprs.url = "github:notashelf/nyxexprs";
    zjstatus.url = "github:dj95/zjstatus";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-master,
    rust-overlay,
    yazi,
    home-manager,
    chaotic,
    quickshell,
    niri,
    # lix-module,
    ...
  }: let
    system = "x86_64-linux";
    host = "hana";
    username = "antonio";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs-master = import nixpkgs-master {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    # Development shell for quickshell QML development
    devShells.${system} = {
      quickshell = let
        qs = quickshell.packages.${system}.default.override {
          withJemalloc = true;
          withQtSvg = true;
          withWayland = true;
          withX11 = false;
          withPipewire = true;
          withPam = true;
          withHyprland = true;
          withI3 = false;
        };
        qtDeps = [
          qs
          pkgs.qt6.qtbase
          pkgs.qt6.qtdeclarative
        ];
      in
        pkgs.mkShell {
          name = "quickshell-dev";
          nativeBuildInputs = qtDeps;
          shellHook = let
            qmlPath = pkgs.lib.makeSearchPath "lib/qt-6/qml" qtDeps;
          in ''
            export QML2_IMPORT_PATH="$QML2_IMPORT_PATH:${qmlPath}"
          '';
        };
    };

    nixosConfigurations = {
      hana = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system inputs username host pkgs-master;
        };
        modules = [
          ./hosts/${host}/config.nix
          chaotic.nixosModules.default
          home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          inputs.catppuccin.nixosModules.catppuccin
          inputs.nixos-hardware.nixosModules.huawei-machc-wa
          inputs.nvf.nixosModules.default
          inputs.mango.nixosModules.mango
          # agenix.nixosModules.default
          # lix-module.nixosModules.default
          # inputs.flake-programs-sqlite.nixosModules.programs-sqlite
          {
            nixpkgs.overlays = import ./overlays {
              inherit inputs system;
            };
          }
        ];
      };
    };
    nixpkgs.overlays = [yazi.overlays.default];
    nixConfig = {
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org?priority=10" # Keep this last
        "https://nyx.chaotic.cx"
        "https://hyprland.cachix.org"
        "https://yazi.cachix.org"
        "https://walker-git.cachix.org"
        "https://walker.cachix.org"
        "https://niri.cachix.org"
        "https://catppuccin.cachix.org" # a cache for all catppuccin ports
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        "catppuccin.cachix.org-1:noG/4HkbhJb+lUAdKrph6LaozJvAeEEZj4N732IysmU="
      ];
    };
  };
}
