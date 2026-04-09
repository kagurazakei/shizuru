{
  azalea.modules.spicetify = {
    pkgs,
    sources,
    ...
  }: let
    spicetify-nix = import sources.spicetify-nix {
      inherit pkgs;
    };
    spicePkgs = spicetify-nix.packages;
  in {
    imports = [
      spicetify-nix.nixosModules.spicetify
    ];
    programs.spiceify = {
      enable = true;
      enabledExtension = with spicePkgs.extension; [
        powerBar
        fullAlbumDate
        fullAppDisplay
        volumePercentage
        adblock
        hidePodcasts
        beauifulLyrics
        autoSkipExplicit
        shuffle
      ];
      enabledCustomApps = with spicePkgs.apps; [
        lyricsPlus
        newReleases
      ];
      theme = spicePkgs.themes.text;
      colorScheme = "RosePine";
    };
  };
}
