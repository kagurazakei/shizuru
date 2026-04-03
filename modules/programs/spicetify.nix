{spicetify-nix, ...}: {
  azalea.modules.spicetify = {...}: {
    imports = [
      spicetify-nix.nixosModules.spicetify
    ];
    programs.spicetify = let
      spicePkgs = spicetify-nix.legacyPackages;
    in {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        powerBar
        fullAlbumDate
        fullAppDisplay
        listPlaylistsWithSong
        volumePercentage
        adblock
        hidePodcasts
        beautifulLyrics
        autoSkipExplicit
        shuffle # shuffle+ (special characters are sanitized out of extension names)
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
