{spicetify-nix, ...}: {
  azalea.modules.spicetify = {
    pkgs,
    inputs,
    ...
  }: {
    imports = [
      spicetify-nix.nixosModules.default
    ];
    programs.spicetify = let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
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
      colorScheme = "CatppuccinMocha";
    };
  };
}
