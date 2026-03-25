{
  writers,
  fzf,
  coreutils,
  gnused,
}:
writers.writeFishBin "npins-ui" ''
  set -g PATH ${coreutils}/bin ${gnused}/bin ${fzf}/bin $PATH

  function resolve_file
    switch $argv[1]
      case start
        echo $NPINS_FILE_START
        or echo start-plugins.json

      case opt
        echo $NPINS_FILE_OPT
        or echo opt-plugins.json

      case sources
        echo $NPINS_FILE_SOURCES
        or echo npins/sources.json

      case '*'
        echo $argv[1] | sed 's|^~|'"$HOME"'|'
    end
  end

  set MODE sources
  if test (count $argv) -gt 0
    set MODE $argv[1]
  end

  set FILE (resolve_file $MODE)

  if not test -f $FILE
    echo "❌ File not found: $FILE"
    exit 1
  end

  function parse
    npins --lock-file $FILE show | awk '
      BEGIN {
        pin=""; type="unknown"; repo="unknown"; rev="unknown";
      }

      /^[a-zA-Z0-9._-]+:/ {
        split($1, a, ":")
        pin=a[1]
        type="unknown"
        repo="unknown"
        rev="unknown"
      }

      /^[[:space:]]*type:/ { type=$2 }

      /^[[:space:]]*repository:/ {
        repo=substr($0, index($0, ":") + 2)
      }

      /^[[:space:]]*revision:/ { rev=$2 }

      /^[[:space:]]*frozen:/ {
        printf "%s|%s|%s|%s\n", pin, type, repo, rev
      }
    '
  end

  parse | fzf \
    --ansi \
    --layout=reverse \
    --border \
    --header="📦 NPins UI (Fish) | file: $FILE" \
    --preview '
      set line {}
      set pin (string split "|" $line)[1]
      set type (string split "|" $line)[2]
      set repo (string split "|" $line)[3]
      set rev (string split "|" $line)[4]

      echo "📦 PIN: $pin"
      echo "🔧 TYPE: $type"
      echo "🌐 REPO: $repo"
      echo "🔖 REV: $rev"
    ' \
    --bind "enter:execute-silent(echo (string split \"|\" {} )[4] | wl-copy)+abort" \
    --bind "ctrl-o:execute-silent(xdg-open https://github.com/(string split \"|\" {} )[3])"
''
