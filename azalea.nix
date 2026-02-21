inputs:
assert inputs ? nixpkgs; let
  inherit
    (inputs.nixpkgs.lib)
    flip
    flatten
    hasSuffix
    filter
    filesystem
    pipe
    recursiveUpdate
    foldAttrs
    ;

  # Recursively collect all .nix files inside a directory
  recursiveImport = path: filter (hasSuffix ".nix") (filesystem.listFilesRecursive path);

  /*
  importModules

  WARNING:
  This function recursively imports and merges modules
  using recursiveUpdate.

  It now includes proper error context so you can see
  exactly which file caused the failure.
  */
  importModules = flip pipe [
    flatten
    (map (
      x:
        if builtins.isPath x
        then let
          file = toString x;
        in
          builtins.addErrorContext "while importing module file: ${file}" (import x)
        else x
    ))
    (map (
      x:
        if builtins.isFunction x
        then builtins.addErrorContext "while evaluating module function" (x inputs)
        else x
    ))
    (foldAttrs recursiveUpdate {})
  ];
in {
  inherit recursiveImport importModules;
}
