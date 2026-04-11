let
  sources = import ../npins;
  lixFlake-compat = import sources.flake-compat;
  lib = import "${sources.unstable}/lib";
  flake-inputs = import sources.flake-inputs;
  inherit
    (builtins)
    filter
    any
    readFile
    readDir
    stringLength
    pathExists
    concatLists
    ;
  inherit
    (lib)
    mapAttrsToList
    hasSuffix
    hasPrefix
    filterAttrs
    ;
in rec {
  flakeToNix = {
    src,
    copySourceTreeToStore ? true,
    useBuiltinsFetchTree ? false,
    system ? builtins.currentSystem or "unknown-system",
  }: (lixFlake-compat {
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

  # files/directories starting with _ and empty files will be ignored. Idea stolen from github.com/vic/import-tree
  # fn: -> []
  recursiveImport = {
    dir,
    excludePrefixedWith ? ["_"],
  }: let
    filteredAttrs =
      readDir dir
      |> (filterAttrs (
        n: v:
          !(any (prefix: hasPrefix prefix n) excludePrefixedWith) && (v == "directory" || hasSuffix ".nix" n)
      ));

    pred = n: type:
      if type == "directory"
      then
        recursiveImport {
          dir = dir + "/${n}";
          inherit excludePrefixedWith;
        }
      else if type == "regular"
      then [(dir + "/${n}")]
      else [];
  in
    concatLists (mapAttrsToList pred filteredAttrs)
    |> (filter (e: (pathExists e) && (stringLength (readFile e)) > 0));
}
