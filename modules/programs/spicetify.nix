{spicetify-nix, ...}: {
  azalea.modules.spicetify = {...}: let
    spicePkgs = spicetify-nix.legacyPackages;
  in {
    imports = [
      spicetify-nix.nixosModules.spicetify
    ];
    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
    };
    # programs.spicetify = {
    #   enable = true;
    #   enabledExtensions = with spicePkgs.extensions; [
    #     powerBar
    #     fullAlbumDate
    #     fullAppDisplay
    #     listPlaylistsWithSong
    #     volumePercentage
    #     adblock
    #     hidePodcasts
    #     beautifulLyrics
    #   ];
    #   enabledCustomApps = with spicePkgs.apps; [
    #     lyricsPlus
    #     newReleases
    #   ];
    #   # theme = spicePkgs.themes.text;
    #   # colorScheme = "RosePine";
    # };
  };
}
