{
  azalea.modules.spicetify = {
    pkgs,
    pins,
    ...
  }: let
    spicePkgs = pins.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    imports = [pins.spicetify-nix.nixosModules.spicetify];
    programs.spicetify = {
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
