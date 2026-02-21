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
    ];

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    systems.url = "github:nix-systems/x86_64-linux";
    crane.url = "github:ipetkov/crane";
    chaotic.url = "github:lonerOrz/nyx-loner";
    silent-sddm.url = "github:kagurazakei/SilentSDDM";
    zakeivim.url = "github:kagurazakei/khanelivim";
    niri.url = "github:kagurazakei/niri";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur-repo-override.url = "github:ilya-fedin/nur-repository";
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
    firefox.url = "github:nix-community/flake-firefox-nightly";
    mnw.url = "github:Gerg-L/mnw";
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-compat.follows = "";
    };
    hjem-impure = {
      url = "github:Rexcrazy804/hjem-impure";
      inputs.nixpkgs.follows = "";
      inputs.hjem.follows = "";
    };
    hjem = {
      url = "github:feel-co/hjem";
      inputs.smfh.follows = "";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-darwin.follows = "";
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
