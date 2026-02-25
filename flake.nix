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
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
    firefox.url = "github:nix-community/flake-firefox-nightly";
    mnw.url = "github:Gerg-L/mnw";
    niri = {
      url = "github:kagurazakei/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sysc-greet = {
      url = "github:Nomadcxx/sysc-greet";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
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
