# let
#   sources = removeAttrs (import ./+npins) ["__functor"];
#   unflake = import sources.flake-compat;
#
#   outputs = sources:
#     builtins.mapAttrs (
#       _: input:
#         if builtins.pathExists "${input}/flake.nix" && !(input ? raw)
#         then (unflake {src = input;}).outputs
#         else input
#     )
#     sources;
# in
#   #
#   (outputs sources
#     //
#     #
#     {
#       qtengine = sources.qtengine // {raw = true;}; # why tf do i need to declare as raw
#     })
let
  sources = removeAttrs (import ./npins) ["__functor"];
  unflake = (import sources.flake-inputs).import-flake;

  outputs = sources:
    builtins.mapAttrs (
      _: input:
        if builtins.pathExists "${input}/flake.nix" && !(input ? raw)
        then
          (unflake {
            src = input;
            overrides =
              {
                nixpkgs = sources.unstable.outPath;
              }
              // (input.overrides or {});
          })
        else input
    )
    sources;
in
  outputs (
    sources
    // {
    }
  )
