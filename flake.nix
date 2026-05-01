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
    systems.url = "github:nix-systems/default-linux";
    crane.url = "github:ipetkov/crane";
    silent-sddm.url = "github:kagurazakei/SilentSDDM";
    mnw.url = "github:Gerg-L/mnw";
    niri = {
      url = "github:kagurazakei/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur-repo-override.url = "github:ilya-fedin/nur-repository";
    booru-hs = {
      url = "github:Rexcrazy804/booru.hs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };
  };
}
