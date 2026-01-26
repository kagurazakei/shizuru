self: super: {
  niri-unstable = super.niri-unstable.overrideAttrs (oldAttrs: rec {
    patches =
      oldAttrs.patches or []
      ++ [
        ./support-shm-shareing.patch
      ];
  });
}
