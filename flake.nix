{
  description = "kagurazakei's Flake";

  # This is the completely stolen from Rexcrazy804/Zaphkiel(dandelion)
  # Presenting, the *azalea* setup
  outputs = {...} @ inputs: let
    azalea = import ./azalea.nix inputs;
    inherit (azalea) importModules recursiveImport;
  in
    importModules [
      (recursiveImport ./modules)
      (recursiveImport ./flake)
    ];

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/x86_64-linux";
    crane.url = "github:ipetkov/crane";
    chaotic.url = "github:lonerOrz/nyx-loner";
    silent-sddm.url = "github:kagurazakei/SilentSDDM";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
    firefox.url = "github:nix-community/flake-firefox-nightly";
    mnw.url = "github:Gerg-L/mnw";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    ambxst.url = "github:kagurazakei/Ambxst?ref=master";
    niri = {
      url = "github:kagurazakei/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprnix.url = "github:hyprwm/hyprnix";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur-repo-override.url = "github:ilya-fedin/nur-repository";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix/2e2234c2932a3aff5f845cda33cb1972a9e889aa";
    hjem-impure = {
      url = "github:Rexcrazy804/hjem-impure";
      inputs.hjem.follows = "";
    };
    hjem = {
      url = "github:feel-co/hjem";
      inputs.smfh.follows = "";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-darwin.follows = "";
    };
    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
    };
    booru-hs = {
      url = "github:Rexcrazy804/booru.hs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
    stash = {
      url = "github:notashelf/stash";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.crane.follows = "crane";
    };
    hs-todo = {
      url = "github:Rexcrazy804/haskell-todo";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
  };
}
