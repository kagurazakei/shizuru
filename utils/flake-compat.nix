{}: let
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
  inherit flakeToNix _flakeToNix;
  fromSource = sourceName: let
    src = sources.${sourceName};
  in
    if src == null
    then throw "Source '${sourceName}' not found in npins"
    else flakeToNix {inherit src;};
  inherit sources;
}
