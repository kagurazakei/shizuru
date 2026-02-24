{...}: {
  azalea.modules.spicetify = {
    pkgs,
    sources,
    ...
  }: {
    imports = [
      (sources.spicetify-nix + "/modules/options.nix")
    ];
    programs.spicetify = let
      spicePkgs = pkgs.callPackage "${sources.spicetify-nix}/pkgs/default.nix" {};
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
    };
  };
}
