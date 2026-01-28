
function _nix_complete
  # Get the current command up to a cursor.
  # - Behaves correctly even with pipes and nested in commands like env.
  # - TODO: Returns the command verbatim (does not interpolate variables).
  #   That might not be optimal for arguments like -f.
  set -l nix_args (commandline --current-process --tokenize --cut-at-cursor)
  # --cut-at-cursor with --tokenize removes the current token so we need to add it separately.
  # https://github.com/fish-shell/fish-shell/issues/7375
  # Can be an empty string.
  set -l current_token (commandline --current-token --cut-at-cursor)

  # Nix wants the index of the argv item to complete but the $nix_args variable
  # also contains the program name (argv[0]) so we would need to subtract 1.
  # But the variable also misses the current token so it cancels out.
  set -l nix_arg_to_complete (count $nix_args)

  env NIX_GET_COMPLETIONS=$nix_arg_to_complete $nix_args $current_token 2>/dev/null
end

function _nix_accepts_files
  set -l response (_nix_complete)
  test $response[1] = 'filenames'
end

function _nix
  set -l response (_nix_complete)
  # Skip the first line since it handled by _nix_accepts_files.
  # Tail lines each contain a command followed by a tab character and, optionally, a description.
  # This is also the format fish expects.
  string collect -- $response[2..-1]
end

# Disable file path completion if paths do not belong in the current context.
complete --command nix --condition 'not _nix_accepts_files' --no-files

complete --command nix --arguments '(_nix)'
complete nix --exclusive

# Common options
complete nix -l debug -d "enable debug output"
complete nix -l help -d "show usage information"
complete nix -l help-config -d "show configuration options"
complete nix -l no-net -d "disable substituters and consider all previously downloaded files up-to-date"
complete nix -l option -d "set a Nix configuration option (overriding nix.conf)"
complete nix -l print-build-logs -s L -d "print full build logs on stderr"
complete nix -l quiet -d "decrease verbosity level"
complete nix -l verbose -s v -d "increase verbosity level"
complete nix -l version -d "show version information"

# Subcommands
# Generated from `nix` help text with:
# string replace --regex '([\w-]+)\s+(.+)' 'complete nix -n __fish_use_subcommand -a $1 -d "$2"'
complete nix -n __fish_use_subcommand -a add-to-store -d "add a path to the Nix store"
complete nix -n __fish_use_subcommand -a build -d "build a derivation or fetch a store path"
complete nix -n __fish_use_subcommand -a cat-nar -d "print the contents of a file inside a NAR file"
complete nix -n __fish_use_subcommand -a cat-store -d "print the contents of a store file on stdout"
complete nix -n __fish_use_subcommand -a copy -d "copy paths between Nix stores"
complete nix -n __fish_use_subcommand -a copy-sigs -d "copy path signatures from substituters (like binary caches)"
complete nix -n __fish_use_subcommand -a doctor -d "check your system for potential problems"
complete nix -n __fish_use_subcommand -a dump-path -d "dump a store path to stdout (in NAR format)"
complete nix -n __fish_use_subcommand -a edit -d "open the Nix expression of a Nix package in $EDITOR"
complete nix -n __fish_use_subcommand -a eval -d "evaluate a Nix expression"
complete nix -n __fish_use_subcommand -a hash-file -d "print cryptographic hash of a regular file"
complete nix -n __fish_use_subcommand -a hash-path -d "print cryptographic hash of the NAR serialisation of a path"
complete nix -n __fish_use_subcommand -a log -d "show the build log of the specified packages or paths, if available"
complete nix -n __fish_use_subcommand -a ls-nar -d "show information about the contents of a NAR file"
complete nix -n __fish_use_subcommand -a ls-store -d "show information about a store path"
complete nix -n __fish_use_subcommand -a optimise-store -d "replace identical files in the store by hard links"
complete nix -n __fish_use_subcommand -a path-info -d "query information about store paths"
complete nix -n __fish_use_subcommand -a ping-store -d "test whether a store can be opened"
complete nix -n __fish_use_subcommand -a repl -d "start an interactive environment for evaluating Nix expressions"
complete nix -n __fish_use_subcommand -a run -d "run a shell in which the specified packages are available"
complete nix -n __fish_use_subcommand -a search -d "query available packages"
complete nix -n __fish_use_subcommand -a show-config -d "show the Nix configuration"
complete nix -n __fish_use_subcommand -a show-derivation -d "show the contents of a store derivation"
complete nix -n __fish_use_subcommand -a sign-paths -d "sign the specified paths"
complete nix -n __fish_use_subcommand -a to-base16 -d "convert a hash to base-16 representation"
complete nix -n __fish_use_subcommand -a to-base32 -d "convert a hash to base-32 representation"
complete nix -n __fish_use_subcommand -a to-base64 -d "convert a hash to base-64 representation"
complete nix -n __fish_use_subcommand -a to-sri -d "convert a hash to SRI representation"
complete nix -n __fish_use_subcommand -a upgrade-nix -d "upgrade Nix to the latest stable version"
complete nix -n __fish_use_subcommand -a verify -d "verify the integrity of store paths"
complete nix -n __fish_use_subcommand -a why-depends -d "show why a package has another package in its closure"
