{}: let
  # Import npins sources
  sources = import ../npins;
  flake-compat = import sources.flake-compat;
  flake-inputs = import sources.flake-inputs;
  flakeToNix = {
    src,
    copySourceTreeToStore ? true,
    useBuiltinsFetchTree ? false,
    system ? builtins.currentSystem or "unknown-system",
  }: (flake-compat {
    inherit
      src
      copySourceTreeToStore
      useBuiltinsFetchTree
      system
      ;
  });

  _flakeToNix = {
    src,
    overrides ? {},
  }:
    (flake-inputs.import-flake {inherit src overrides;}).self.outputs;
in {
  # The main function you want
  inherit flakeToNix _flakeToNix;

  # Convenience wrapper for your specific sources
  fromSource = sourceName: let
    src = sources.${sourceName};
  in
    if src == null
    then throw "Source '${sourceName}' not found in npins"
    else flakeToNix {inherit src;};

  # Direct access to npins sources
  inherit sources;
}
